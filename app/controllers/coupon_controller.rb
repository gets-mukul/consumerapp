class CouponController < ApplicationController
  def apply
	if ['SOCIAL150', 'REFER150'].include? params[:promo_code]
      session[:coupon_applied] = true
      return redirect_to '/?applied=true&promo=' + params[:promo_code].downcase
    end
    return redirect_to '/'
  end
end
