ActiveAdmin.register Consultation do
  require 'encrypt'
  
  scope :all, :default => true, show_count: false
  scope "Registered", show_count: false
  scope "Form filled", show_count: false
  scope "Paid", show_count: false
  scope "Free", show_count: false
  scope "Payment Failed", show_count: false

  filter :patient
  filter :coupon
  filter :category, :as => :select
  filter :user_status
  filter :amount
  filter :pay_status
  filter :created_at
  filter :updated_at

  permit_params :coupon_id, :category, :user_status, :pay_status, :amount, :payment
  actions :all, :except => [:new, :destroy]

  action_item :edit_pay_status, only: [:show, :edit] do
    link_to 'Update Pay Status', edit_pay_status_admin_consultation_path
  end
  
  controller do
    include Pundit
    include PaymentHelper
    protect_from_forgery
    rescue_from Pundit::NotAuthorizedError, with: :admin_user_not_authorized
    before_action :authenticate_admin_user!
    before_action :coupon_empty? , only: [:update]

    def scoped_collection
      super.includes :patient, :coupon, :doctor
    end

    def coupon_empty?
      params[:consultation][:coupon_id] = nil if params[:consultation][:coupon_id].blank?
    end
    
    def update
      if params[:commit] == "Update Consultation"
        update_amount
        super
      elsif params[:commit] == "Update Payment Status"
        if params[:consultation][:pay_status] != resource.pay_status
          resource.pay_status = params[:consultation][:pay_status]
          resource.patient.update({ :pay_status => params[:consultation][:pay_status] })
          
          if params[:consultation][:pay_status] == "paid"
            resource.user_status = "paid"
            
            payment = Payment.find_by :consultation_id => resource.id
            if payment
              payment_params = {
                :status => "paid"
              }
              
              payment_params[:pg_type] = params[:payment][:pg_type] if params[:payment][:pg_type]
              payment_params[:bank_ref_num] = params[:payment][:bank_ref_num] if params[:payment][:bank_ref_num]
              payment_params[:mode] = "manual entry"
              
              payment.update(payment_params)
            else
              if params[:payment][:pg_type]
                txn_id = build_transaction_id_external resource.patient
                payment_params = {
                  :txnid => txn_id,
                  :status => "paid",
                  :desc => "Remedico treatment for #{resource.patient.name}",
                  :amount => resource.amount,
                  :consultation => resource
                }
                payment_params[:pg_type] = params[:payment][:pg_type]
                payment_params[:bank_ref_num] = params[:payment][:bank_ref_num]
                payment_params[:mode] = "manual entry"
                
                resource.patient.payments.create(payment_params)
              end
            end
          end
          resource.save
        end
        redirect_to admin_consultation_path(resource)
      end
    end
    
    def update_amount
      if params["consultation"]["coupon_id"].blank?
        params["consultation"]["amount"] = 350
      else
        coupon = Coupon.find(params["consultation"]["coupon_id"]) 
        if coupon
          params["consultation"]["amount"] = 350 - coupon.discount_amount
        end
      end
    end
      
    def pundit_user
      current_admin_user
    end
    
    def action_methods
      if current_admin_user.admin?
        super
      else
        super - ['edit']
      end
    end
          
    private
      def admin_user_not_authorized
        flash[:alert]="Access denied"
        redirect_to (request.referrer || admin_root_path)
      end
  end

  index do
    column :created_at
    column :id
    column :patient
    column :coupon
    column :amount
    
    column "Mobile" do |cs|
        cs.patient.mobile
    end
    
    column :user_status
    column :pay_status
    column "Doctor" do |cs|
      cs.doctor.short_name if cs.doctor
    end
    column :updated_at
    actions
  end
  
  show do
    div class: "row" do
      div class: "col-md-6 col-sm-12 col-xs-12" do
        attributes_table do
          row :patient
          row("Patient ID") {consultation.patient_id}
          row :category
          row :user_status
          row :amount
          row :coupon
          row :pay_status
          row :created_at
          row :updated_at

          row("Payment link") {
            if consultation.user_status != 'registered'
              "bit.do/rmpay?p=" + encrypt(consultation)
            else
              ""
            end
          }

          row("Login link") { "bit.do/rme?p=" + encrypt(consultation.patient) }

          panel "Patient" do
            table_for Patient.select(:id, :mobile, :email).where(:id => consultation.patient_id)  do
              column "Patient ID" do |p|
                link_to p.id, admin_patient_path(p.id)
              end
              column :mobile
              column :email
            end
          end
        end
      end

      div class: "col-md-6 col-sm-12 col-xs-12" do
        active_admin_comments
      end
    end

    div class: "row" do
      div class: "col-md-12 col-sm-12 col-xs-12" do
        panel "All Consultations" do
          table_for Consultation.where(:patient_id => consultation.patient_id).joins('LEFT OUTER JOIN patient_sources on patient_sources.consultation_id=consultations.id').order('consultations.id, patient_sources.created_at').select('DISTINCT on (consultations.id) consultations.created_at, consultations.id, consultations.coupon_id, consultations.user_status, consultations.pay_status, patient_sources.local_referrer, patient_sources.utm_campaign') do
            column :created_at
            column "Consultation ID" do |cs|
              link_to cs.id, admin_consultation_path(cs.id)
            end
            column "Coupon" do |cs|
              cs.coupon
            end

            column :user_status
            column :pay_status
            column :local_referrer
            column :utm_campaign
          end
        end
      end
    end

    div class: "row" do
      div class: "col-md-12 col-sm-12 col-xs-12" do
        panel "Source data" do
          table_for PatientSource.select(:created_at, :local_referrer, :utm_campaign, :consultation_id).where(:patient_id => consultation.patient_id).order('created_at ASC')  do
            column :created_at
            column "Consultation ID" do |ps|
              link_to ps.consultation_id, admin_consultation_path(ps.consultation_id)  if ps.consultation_id?
            end
            column :local_referrer
            column :utm_campaign
            column ""
            column ""
            column ""
          end
        end
      end
    end

    div class: "row" do
      div class: "col-md-12 col-sm-12 col-xs-12" do
        panel "Transactions" do
          table_for Payment.select(:created_at, :id, :status, :amount, :pg_type, :consultation_id, :updated_at).where(:patient_id => consultation.patient_id).order('created_at ASC')  do
            column :created_at
            column "Consultation ID" do |p|
              link_to p.consultation_id, admin_consultation_path(p.consultation_id)
            end
            column "ID" do |p|
              link_to p.id, admin_payment_path(p.id)
            end
            column :status
            column :amount
            column :pg_type
            column :updated_at
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Edit" do

      li class: "email input required stringish" do
        label "Email", class: "label"
        span do
          strong { resource.patient }
        end
      end
      
      f.input :coupon
      f.input :category, :include_blank => false, :collection => ['Skin Growth (Moles, Warts)', 'Acne', 'Pigmentation and Dark Circles', 'Eczema, Psoriasis and Rash', 'Stretch Marks', 'Dandruff', 'Hairfall or Hair Thinning'] 
      f.input :user_status, :include_blank => false, :collection => ["payment failed", "form filled", "payment failed : Sorry, but we cannot treat your ailment. Please schedule an appointment at a nearby hospital.", "free consultation done", "registered"] #, "paid"]
      f.actions
    end
  end
  
  member_action :edit_pay_status, :method => :get do
    @consultation = resource
  end

  csv force_quotes: true, col_sep: ';' do
    column :created_at
    column :id, :label => 'Consultation id'
    column :patient
    column "Mobile" do |cs|
      cs.patient.mobile
    end
    column :category
    column :user_status
    column :coupon
    column :amount
    column :pay_status

    column :updated_at

    column "Local Referrer" do |cs|
      PatientSource.where(:consultation_id => cs.id).order(:created_at).pluck(:local_referrer).map {|e| e ? e : "nil"} * ", "
    end

    column "UTM Campaign" do |cs|
      PatientSource.where(:consultation_id => cs.id).order(:created_at).pluck(:local_referrer).map {|e| e ? e : "nil"} * ", "
    end
  end
end
