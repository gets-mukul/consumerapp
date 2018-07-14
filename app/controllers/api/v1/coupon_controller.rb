class Api::V1::CouponController < Api::V1::ApiController

	def apply
		# apply 100 coupon if its 150
		if ['SOCIAL150', 'REFER150'].include? params[:promo_code]
			params[:promo_code] = params[:promo_code].sub '150', '100'
		end

		@coupon = Coupon.find_by :coupon_code => params[:promo_code]

		# check if coupon exists
		if @coupon
			# check if coupon it has been exhausted, or expired
			if ((@coupon.count<@coupon.max_count) && (@coupon.expires_on.present? ? Time.now <= @coupon.expires_on : true))
				@coupon.update(status: 'coupon entered')
				session[:coupon_applied] = true
				session[:promo_code] = params[:promo_code]
				render json: { status: 'success', coupon: params[:promo_code], :discount_price => (350 - @coupon.discount_amount)}, status: :ok
			else
				render json: { status: 'coupon expired' }, status: :not_found
			end
		else
			render json: { status: 'coupon not found' }, status: :not_found
		end
	end

end
