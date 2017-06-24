class CouponController < ApplicationController
  def apply
    if params[:promo_code] == 'DISCOUNT100'
      session[:coupon_applied] = true
      return redirect_to '/?applied=true'
    end
    return redirect_to '/'
  end
end
