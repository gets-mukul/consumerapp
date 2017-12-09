ActiveAdmin.register SelfieForm do

  permit_params :doctor_id

  filter :id
  filter :patient
  filter :status, :as => :select
  filter :doctor, :as => :select
  filter :created_at
  filter :updated_at

  # scope :all, :default => true, show_count: false
  # scope "Created today"
  scope "To be diagnosed", :default => true
  scope "Unclear photos"
  scope "To be sent out"
  scope "No conditions"
  actions :all, :except => [:new, :destroy]
  
  batch_action :destroy, false
  batch_action :edit, form: {
    doctor: Doctor.all.map { |doctor| [doctor.short_name, doctor.id] }
  } do |ids, inputs|
    SelfieForm.where(:id => ids).update_all(:doctor_id => inputs["doctor"]) 
    redirect_to collection_path, notice: "Updated doctor."
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
    column :status
    column :doctor
    column :diagnosis_link
    column :updated_at
    actions
  end
  
  controller do
    def scoped_collection
      super.includes :patient, :doctor
    end
  end
  
  show do
    attributes_table do
      row :patient
      row("Image URL") { selfie_form.image_url.to_s }
      row("Image") { image_tag selfie_form.image_url(:medium).to_s }
      row :status
      row :diagnosis_link
      row :doctor
      row :created_at
      row :updated_at
    end
  end

end
