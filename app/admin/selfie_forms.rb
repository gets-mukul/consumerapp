ActiveAdmin.register SelfieForm do
  require 'urlsafe_encrypt'
  permit_params :doctor_id, :diagnosis_link, :status

  filter :id
  filter :patient_name, as: :string
  filter :patient_mobile, as: :string
  filter :status, :as => :select
  filter :doctor, :as => :select
  filter :created_at
  filter :updated_at

  # scope :all, :default => true, show_count: false
  # scope "Created today"
  scope "To be diagnosed", :default => true
  scope "Unclear photos"
  scope "No conditions"
  scope "Diagnosed"
  scope "Diagnosis sent"
  scope :all
  actions :all, :except => [:new, :destroy]
  
  batch_action :destroy, false
  batch_action :change_doctor, form: {
    doctor: Doctor.all.map { |doctor| [doctor.short_name, doctor.id] }
  } do |ids, inputs|
    SelfieForm.where(:id => ids, :status => 'pending').update_all(:doctor_id => inputs['doctor'])
    redirect_to collection_path, notice: 'Updated doctor.'
  end
  batch_action :change_status, form: {
    status: ['bad-photo', 'sent']
  } do |ids, inputs|
    SelfieForm.where(:id => ids).update_all(:status => inputs['status'])
    redirect_to collection_path, notice: 'Updated status.'
  end

  index do
    
    panel "" do
      div class: "blank_slate_container", id: "dashboard_default_message" do
        columns do
          column do
            div class: "section statistics" do
              ul class: "statistics statistics-stats row" do
                li class: "col-md-3 col-sm-6 col-xs-6" do 
                  div class: "statistics statistics-stats-value" do SelfieForm.count end
                  div class: "statistics statistics-stats-label" do "Total<br>selfies".html_safe end
                end
                li class: "col-md-3 col-sm-6 col-xs-6" do 
                  div class: "statistics statistics-stats-value" do SelfieForm.where("created_at >= ?", Time.zone.now.beginning_of_day).count end
                  div class: "statistics statistics-stats-label" do "Selfies<br>today".html_safe end
                end
                li class: "col-md-3 col-sm-6 col-xs-6" do 
                  div class: "statistics statistics-stats-value" do SelfieForm.where(:status => 'pending').count  end
                  div class: "statistics statistics-stats-label" do "To be<br>diagnosed".html_safe end
                end
                li class: "col-md-3 col-sm-6 col-xs-6" do 
                  div class: "statistics statistics-stats-value" do SelfieForm.where(:status => 'diagnosed').count  end
                  div class: "statistics statistics-stats-label" do "To be<br>sent".html_safe end
                end
              end
            end
          end
        end
      end
    end
    selectable_column
    column :created_at
    column :id
    column :patient
    column "Mobile" do |selfie_form|
      selfie_form.patient.mobile
    end
    column :status
    column :doctor
    column :diagnosis_link
    column "Shortened URL" do |selfie_form|
      selfie_form.diagnosis_link ? "bit.do/rmselfie?s=" + selfie_form.diagnosis_link.split('=').last : ""
    end
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :patient
      row("Mobile") { selfie_form.patient.mobile }
      row("Image URL") { selfie_form.selfie_image.image.to_s if selfie_form.selfie_image }
      row("Image") { image_tag((selfie_form.selfie_image.image.to_s if selfie_form.selfie_image), width: '320') }
      row :status
      row :diagnosis_link
      row("Sortened URL") { selfie_form.diagnosis_link ? "bit.do/rmselfie?s=" + selfie_form.diagnosis_link.split('=').last : "" }
      row :doctor
      row :created_at
      row :updated_at
      row("Conditions") { selfie_form.conditions.to_sentence }
    end
  end

  controller do
    include Pundit
    protect_from_forgery
    rescue_from Pundit::NotAuthorizedError, with: :admin_user_not_authorized
    before_action :authenticate_admin_user!
    before_action :authorize_activity

    def authorize_activity
      authorize SelfieForm
    end

    def scoped_collection
      super.includes :patient, :doctor
    end

    def pundit_user
      current_admin_user
    end

    private
      def admin_user_not_authorized
        flash[:alert]="Access denied"
        redirect_to (request.referrer || admin_root_path)
      end
  end

  csv force_quotes: true, col_sep: ',' do
    column :created_at
    column 'Selfie form id' do |selfie_form|
      selfie_form.id
    end
    column :patient
    column 'Mobile' do |selfie_form|
      selfie_form.patient.mobile
    end

    column :status
    column :updated_at
    column "Conditions" do |selfie_form|
      selfie_form.conditions.join(', ')
    end
  end
end
