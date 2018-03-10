ActiveAdmin.register PatientReferral do
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
  config.filters = false
  config.clear_action_items!
  actions :all, :except => [:new, :destroy]

  batch_action :destroy, false
  batch_action :change_refund_status_to_paid do |ids, inputs|
    PatientReferral.where(:id => ids).update_all(:refunded => true)
    redirect_to collection_path, notice: "Updated referrals status."
  end
  batch_action :change_refund_status_to_unpaid do |ids, inputs|
    PatientReferral.where(:id => ids).update_all(:refunded => false)
    redirect_to collection_path, notice: "Updated referrals status."
  end

  form do |f|
    f.inputs "Edit" do
      f.input :paid
      f.input :refunded
      f.input :referrer_amount
      f.actions
    end
  end

end
