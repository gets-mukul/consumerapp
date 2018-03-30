ActiveAdmin.register Payment do
  actions :all, :except => [:new, :destroy, :edit]

  scope :all, :default => true, show_count: false
  scope "Paid", show_count: false

  filter :patient_name, as: :string
  filter :patient_mobile, as: :string
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

  csv force_quotes: true, col_sep: ',' do
    column :created_at
    column "Consultation id" do |payment|
      payment.consultation.id
    end
    column :patient
    column "Mobile" do |payment|
      payment.patient.mobile
    end
    column :txnid
    column :status
    column :amount
    column :mode
    column :pg_type
    column :bank_ref_num

    column "Age" do |payment|
      payment.patient.age
    end
    column "Sex" do |payment|
      payment.patient.sex
    end
    column "City" do |payment|
      payment.patient.city
    end
    column "Category" do |payment|
      payment.consultation.category
    end
    column "User Status" do |payment|
      payment.consultation.user_status
    end
    column "Coupon" do |payment|
      payment.consultation.coupon
    end
    column :amount, :label => 'Amount'
    column "Pay Status" do |payment|
      payment.consultation.pay_status
    end
    column "Local referrer" do |payment|
      PatientSource.where(:patient_id => payment.consultation.patient_id).order(:created_at).pluck(:local_referrer).collect {|obj| obj.present? ? obj : "nil"} * ", "
    end
    column "UTM campaign" do |payment|
      PatientSource.where(:patient_id => payment.consultation.patient_id).order(:created_at).pluck(:utm_campaign).collect {|obj| obj.present? ? obj : "nil"} * ", "
    end
    column :updated_at, :label => 'Paid at'
  end

end
