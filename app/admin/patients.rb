ActiveAdmin.register Patient do
  require 'encrypt'
  actions :all, :except => [:new, :destroy]
  permit_params :name, :mobile, :email


  scope :all, :default => true, show_count: false
  scope "Payment Pending", show_count: false
  scope "Free", show_count: false
  scope "Payment Failed", show_count: false
  scope "Paid", show_count: false
  scope "Red Flags", show_count: false

  filter :id, :label => 'Patient ID'
  filter :mobile
  filter :email
  filter :name
  filter :pay_status
  filter :created_at
  filter :updated_at

  index do
    column :id do |p|
      link_to p.id, admin_patient_path(p.id)
    end
    column :created_at

    column "Name" do |p|
      link_to p.name, admin_patient_path(p.id)
    end

    column :mobile
    column :email
    column :pay_status

    actions defaults: true
  end

  show do
    attributes_table do
      row :name
      row :id
      row :mobile
      row :email
      row :age
      row :sex
      row :city
      row :pay_status
      row :created_at
      row :updated_at
      row("Login link") { "https://bit.do/rme?p=" + encrypt(patient) }
      row("Customer Referral link") {
        if patient.pay_status == 'paid'
          Rails.application.secrets.DOMAIN_NAME+"/?applied=true&promo=REFER100&refpt=" + encrypt(patient)
        else
         ""
        end
      }

      attributes_table do
        row("Login link full shortened") { "https://bit.do/rme?p=" + encrypt(patient) + "&utm_source=crm&utm_medium=whatsapp&referrer=crm&utm_campaign=crm_wa_aish"}
        row("Login link full") { "https://remedicohealth.com/consult/patients/instant_login?p=" + encrypt(patient) + "&utm_source=crm&utm_medium=whatsapp&referrer=crm&utm_campaign=crm_wa_aish" }
      end

      active_admin_comments

      panel "All Consultations" do
        table_for Consultation.where(:patient_id => patient.id).joins('LEFT OUTER JOIN patient_sources on patient_sources.consultation_id=consultations.id').order('consultations.id, patient_sources.created_at').select('DISTINCT on (consultations.id) consultations.created_at, consultations.id, consultations.coupon_id, consultations.user_status, consultations.pay_status, patient_sources.local_referrer, patient_sources.utm_campaign') do
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

      panel "Source data" do
        table_for PatientSource.select(:created_at, :local_referrer, :utm_campaign, :consultation_id).where(:patient_id => patient.id).order('created_at ASC')  do
          column :created_at
          column "Consultation ID" do |ps|
            link_to ps.consultation_id, admin_consultation_path(ps.consultation_id)  if ps.consultation_id? 
          end
          column :local_referrer
          column :utm_campaign
        end
      end

      panel "All Consultations' questionnaire" do
        table_for QuestionnaireResponse.where(:consultation => patient.consultations) do
          column :created_at
          column :consultation
          column :id
          column :status
          column :form_finished_at
          column :updated_at
        end
      end

    end
  end

  controller do
    include Pundit
    protect_from_forgery
    rescue_from Pundit::NotAuthorizedError, with: :admin_user_not_authorized
    before_action :authenticate_admin_user!

    def pundit_user
      current_admin_user
    end

    def action_methods
      if current_admin_user and current_admin_user.admin?
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
  
  form do |f|
  f.inputs "Edit" do
    f.input :name
    f.input :email
    f.input :mobile
    f.actions
  end
end
  
end
