class CouponController < ApplicationController

	def apply

		if ['SOCIAL150', 'REFER150'].include? params[:promo_code]
			session[:coupon_applied] = true
			session[:promo_code] = params[:promo_code]
			return redirect_to '/?applied=true&promo=' + params[:promo_code].downcase
		elsif params[:promo_code] == "SODELHI"
			coupon_name = "SODELHI" + params[:coupon].upcase

			@coupon = Coupon.find_by coupon_code: coupon_name

			if @coupon
				session[:coupon_applied] = true
				if @coupon.status == 'coupon used'
					render :json => { :value => "invalid" }
					logger.info 'RETURN FAILURE'
				else
					if @coupon.count < @coupon.max_count
						@coupon.update(status: 'coupon entered')
						session[:promo_code] = coupon_name
						render :json => { :value => "success" }
						logger.info 'RETURN SUCCESS'
					else
						render :json => { :value => "invalid" }
						logger.info 'RETURN FAILURE'
					end
				end
			else
				render :json => { :value => "not exists" }
				logger.info 'NOT EXISTS'
			end
		else
			return redirect_to '/'
		end

	end


end
