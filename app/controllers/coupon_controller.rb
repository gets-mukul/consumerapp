class CouponController < ApplicationController
  def apply
	if ['SOCIAL100', 'REFER100'].include? params[:promo_code]
      session[:coupon_applied] = true
      return redirect_to '/?applied=true&' + params[:promo_code].downcase
    end
    return redirect_to '/'
  end
end
