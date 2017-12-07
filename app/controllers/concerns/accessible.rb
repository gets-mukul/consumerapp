module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_admin_user
      flash.clear
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(admin_root_path) && return
    elsif current_doctor
      flash.clear
      # The doctor root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(authenticated_doctor_root_path) && return
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin_user
      admin_root_path
    elsif resource_or_scope == :doctor
      authenticated_doctor_root_path
    end
  end
end
