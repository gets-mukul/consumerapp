ActiveAdmin.register MyConsultation do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  filter :name
  filter :mobile
  filter :email
  filter :coupon_coupon_code, as: :string, :label => 'Coupon code'
  filter :category, :as => :select
  filter :user_status
  filter :pay_status
  filter :amount
  filter :txn_id
  filter :local_referrer
  filter :utm_campaign
  filter :created_at
  filter :updated_at

end
