ActiveAdmin.register Payment do
  actions :all, :except => [:new, :destroy, :edit]

  controller do
    include Pundit
    protect_from_forgery
    rescue_from Pundit::NotAuthorizedError, with: :admin_user_not_authorized
    before_action :authenticate_admin_user!
    before_action :authorize_activity

    def authorize_activity
      authorize Payment
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
