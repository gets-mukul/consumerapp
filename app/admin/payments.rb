ActiveAdmin.register Payment do
  actions :all, :except => [:new, :destroy, :edit]

  scope :all, :default => true, show_count: false
  scope "Paid", show_count: false

  filter :patient_name, as: :string
  filter :consultation_id, as: :numeric, :label => 'Consultation ID'
  filter :txnid
  filter :status
  filter :amount
  filter :mode
  filter :pg_type
  filter :bank_ref_num
  filter :created_at
  filter :updated_at

  index do
    column :id
    column :txnid
    column :status
    column :amount
    column :mode
    column :pg_type
    column :bank_ref_num
    column :patient
    column :consultation
    column :created_at
    column :updated_at
    actions
  end

  controller do
    include Pundit
    protect_from_forgery
    rescue_from Pundit::NotAuthorizedError, with: :admin_user_not_authorized
    before_action :authenticate_admin_user!
    before_action :authorize_activity

    def scoped_collection
      super.includes :patient, :consultation
    end

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
