class CouponController < ApplicationController

	def apply
		Rails.logger.info("Coupon Controller: Applying coupon");

		# check if a coupon has been applied
		if params[:promo_code] == "COUPON"
			coupon_name = params[:coupon]
			# check if the coupon is for 150 off, if it is, give away 100 off 
			if ['SOCIAL150', 'REFER150'].include? coupon_name
				coupon_name = coupon_name.sub '150', '100'
			end

			@coupon = Coupon.find_by coupon_code: coupon_name
			if @coupon
				if ((@coupon.count<@coupon.max_count) && (@coupon.expires_on.present? ? Time.new <= @coupon.expires_on : true))
					@coupon.update(status: 'coupon entered')
					session[:coupon_applied] = true
					session[:promo_code] = coupon_name
					cost = 350 - @coupon.discount_amount;
					logger.info 'RETURN SUCCESS'
					render :json => { :value => "success", :discount_price => cost }
				else
					logger.info 'RETURN FAILURE'
					render :json => { :value => "invalid" }
				end
			else
				logger.info 'NOT EXISTS'
				render :json => { :value => "not exists" }
			end
		# temporary
		# check if he has come via SODELHI coupons
		elsif params[:promo_code] == "SODELHI"
			coupon_name = "SODELHI" + params[:coupon]
			@coupon = Coupon.find_by coupon_code: coupon_name
			if @coupon
				if @coupon.status == 'coupon used'
					logger.info 'RETURN FAILURE'
					render :json => { :value => "invalid" }
				else
					if @coupon.count < @coupon.max_count
						@coupon.update(status: 'coupon entered')
						session[:coupon_applied] = true
						session[:promo_code] = coupon_name
						logger.info 'RETURN SUCCESS'
						render :json => { :value => "success" }
					else
						logger.info 'RETURN FAILURE'
						render :json => { :value => "invalid" }
					end
				end
			else
				logger.info 'NOT EXISTS'
				render :json => { :value => "not exists" }
			end
		else
			render :json => { :value => "failure" }
			# return redirect_to '/'
		end
	end
end
