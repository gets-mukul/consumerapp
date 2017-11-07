ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role
  actions :all, :except => [:destroy]

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column "" do |user|
      link_to "View", admin_admin_user_path(user.id)
    end
    column "" do |user|
      link_to "Edit Role", edit_role_admin_admin_user_path(user.id)
    end
  end
  
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role if f.object.new_record?
    end
    f.actions
  end
  
  show do
    attributes_table do
      row :email
      row :role
      row :remember_created_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :updated_at
      
      row "Local Referrer" do |cs|
          ps = PatientSource.find_by :consultation_id => cs.id
          ps.local_referrer if ps
      end
      
      row "UTM Campaign" do |cs|
          ps = PatientSource.find_by :consultation_id => cs.id
          ps.utm_campaign if ps
      end
      
      row "Payment link" do |cs|
          "bit.do/rmpay?p=" + encrypt(cs)
      end
      
      active_admin_comments
    end
  end

  member_action :edit_role, method: :get do
    redirect_to resource_path(resource)
  end

  action_item :edit, only: :index do
    link_to "Edit My Account", edit_admin_admin_user_path(current_admin_user.id)
  end

  controller do
    include Pundit
    protect_from_forgery
    rescue_from Pundit::NotAuthorizedError, with: :admin_user_not_authorized
    before_action :authenticate_admin_user!
    before_action :authorize_activity

    def authorize_activity
      authorize current_admin_user
    end

    def edit_role
      @edit_user = resource
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
end
