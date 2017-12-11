ActiveAdmin.register Doctor do

  permit_params :email, :first_name, :last_name, :mobile, :location, :qualification, :desc, :experience, :available_for_consultation, :available_for_selfie_checkup, :password
  config.filters = false
  actions :all, :except => [:new, :destroy]
  action_item :edit, only: :show do
    link_to "Change Password", change_admin_doctor_path
  end
  
  batch_action :destroy, false
  
  batch_action :disable_doctor_for_consultations do |ids, inputs|
    Doctor.where(:id => ids).update_all(:available_for_consultation => false) 
    redirect_to collection_path, notice: "Updated doctor status."
  end

  batch_action :enable_doctor_for_consultations do |ids, inputs|
    Doctor.where(:id => ids).update_all(:available_for_consultation => true)
    redirect_to collection_path, notice: "Updated doctor status."
  end
  
  batch_action :disable_doctor_for_selfie_checkups do |ids, inputs|
    Doctor.where(:id => ids).update_all(:available_for_selfie_checkup => false) 
    redirect_to collection_path, notice: "Updated doctor status."
  end

  batch_action :enable_doctor_for_selfie_checkups do |ids, inputs|
    Doctor.where(:id => ids).update_all(:available_for_selfie_checkup => true)
    redirect_to collection_path, notice: "Updated doctor status."
  end
  
  member_action :change, method: :get do
    redirect_to resource_path(resource)
  end

  index do
    selectable_column
    column :id
    column :short_name
    column :updated_at
    column "Consultations", :available_for_consultation
    column "Selfie Checkups", :available_for_selfie_checkup
    actions
  end

  form do |f|
    f.inputs "Edit" do

      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :mobile
      f.input :location
      f.input :qualification
      f.input :desc
      f.input :experience
      
      f.actions
    end
  end

  show do
    attributes_table do
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
      row :full_name
      row :mobile
      row :location
      row :avatar
      row :qualification
      row("Description") { doctor.desc.html_safe }
      row :experience
      row :available_for_consultation
      row :available_for_selfie_checkup
      row :consultations_count
      row :selfies_count
      row :code
    end
  end

  controller do
    def change
      @doctor = resource
    end
  end
end
