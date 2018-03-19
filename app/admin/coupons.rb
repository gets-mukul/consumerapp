ActiveAdmin.register Coupon do
  permit_params :discount_amount, :coupon_code, :expires_on, :max_count, :coupon_category, :expires_on, :coupon_n_coupons_to_generate
  config.clear_action_items!
  
  action_item :new, only: :index do
    link_to "Create coupon(s)", new_admin_coupon_path
  end
  action_item :edit, only: :show do
    link_to "Edit coupon", edit_admin_coupon_path
  end

  scope :all, :default => true, show_count: false
  scope "Used", show_count: false
  scope "Promos", show_count: false
  
  controller do
    include Pundit
    protect_from_forgery
    rescue_from Pundit::NotAuthorizedError, with: :admin_user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :coupon_creation_error
    before_action :authenticate_admin_user!
    before_action :authorize_activity

    def authorize_activity
      authorize Coupon
    end

    def update
      params["coupon"]["max_count"] = params["coupon"]["max_count"].empty? ? 2147483647 : params["coupon"]["max_count"]
      super
    end

    def create(options={}, &block)
      hash = {
        discount_amount: params["coupon"]["discount_amount"],
        status: "coupon unused",
        count: 0,
        max_count: params["coupon"]["max_count"]
      }
      if params["coupon"]["max_count"] == ''
        hash[:max_count] = 2147483647
      else
        hash[:max_count] =  params["coupon"]["max_count"]
      end
      
      hash[:max_count] = params["coupon"]["max_count"].empty? ? 2147483647 : params["coupon"]["max_count"]
      
      expires_on = params["expires_on"]
      expires_on.delete_if { expires_on["date(1i)"].blank? || expires_on["date(2i)"].blank? || expires_on["date(3i)"].blank? }
      if expires_on.present?
        hash[:expires_on] = DateTime.new(*expires_on.values.map(&:to_i))
      end
      
      if params['generate_checkbox'] != 'on'
        hash[:coupon_code] = params["coupon"]["coupon_code"].upcase

        if Coupon.find_by :coupon_code => hash[:coupon_code]
          flash[:alert]="Coupon already exists, please select a different name."
          return redirect_to request.referrer
        else
          coupon = Coupon.new(hash)
          if coupon.save
            options[:location] ||= admin_coupon_path(coupon.id)
          end
        end
      else
        # letters = (
        #   ('B'..'D').to_a +
        #   ('F'..'H').to_a + 
        #   ('J'..'N').to_a + 
        #   ('R'..'T').to_a +
        #   ('V'..'Z').to_a + 
        #   (2..9).to_a
        # ) 
        
        letters = ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "R", "S", "T", "V", "W", "X", "Y", "Z", 2, 3, 4, 5, 6, 7, 8, 9].shuffle
        n = params["coupon_n_coupons_to_generate"].to_i;
        
        uniq_codes = letters.permutation(4).to_a
        uniq_codes.map! { |item| params["coupon"]["category"] + item.join() }
        uniq_codes = uniq_codes.shuffle
        selected_uniq_codes = [];
        i = 0;
        loop do
          unless Coupon.find_by :coupon_code => uniq_codes[i]
            selected_uniq_codes << uniq_codes[i]
          end
          i = i + 1
          break if selected_uniq_codes.length == n
        end

        coupons = []
        for i in 0...n do
          coupons.push(hash.merge(coupon_code: uniq_codes[i]))
        end
        
        Coupon.create(coupons)
        flash[:notice] = 'Coupon was successfully created'
        
        options[:location] ||= admin_coupons_path
      end
      respond_with_dual_blocks(coupon, options, &block)
    end
    
    def pundit_user
      current_admin_user
    end
      
    private
      def admin_user_not_authorized
        flash[:alert]="Access denied"
        redirect_to (request.referrer || admin_root_path)
      end
      
      def coupon_creation_error
        flash[:alert]="Please fill in all the manadatory fields."
        redirect_to (request.referrer || new_admin_coupon_path )
      end
  end

  form :partial => "new"
  
  show do
    attributes_table do
      row :coupon_code
      row :discount_amount
      row :status
      row :expires_on
      row :count
      row :max_count
      row :created_at
      row :updated_at
      row "Coupon link" do |c|
        # if c.discount_amount == 350 || c.coupon_code.starts_with?("SOCIAL") || c.coupon_code.starts_with?("REFER")
        #   "remedicohealth.com/?applied=true&promo=" + c.coupon_code
        # else
        #   ""
        # end
        "https://remedicohealth.com/?applied=true&promo=" + c.coupon_code
      end
      active_admin_comments
    end
  end
  
  index do
    selectable_column
    column :id do |c|
      link_to c.id, admin_coupon_path(c.id)
    end
    column :coupon_code
    column :discount_amount
    column :status
    column :expires_on
    column :count
    column :max_count
    column :created_at
    column :updated_at
    actions
  end
end
