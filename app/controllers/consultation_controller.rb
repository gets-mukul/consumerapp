class ConsultationController < ApplicationController
  # before_action :check_current_user
  before_filter :check_current_user, except: [:new, :create]
  

  def index
    # fetch current user and condition from session if user choce a condition
    @patient = current_user
    @condition = session[:condition]

    # fetch the last consultation from this user
    @fetched_consultation = Consultation.where(:patient_id => current_user.id).last
    if @fetched_consultation.present?
      # show the associated view depending on patient's previous consultation's status
      if @fetched_consultation.user_status == 'registered'
        Rails.logger.info 'Consultation Controller: Rendering navigation menu - registered'
        render 'navigation_menu_on_registered'
      elsif ['form filled', 'payment failed : '].include? @fetched_consultation.user_status or @fetched_consultation.user_status.end_with?('has cancelled the payment')
        Rails.logger.info 'Consultation Controller: Rendering navigation menu - form filled'
        render 'navigation_menu_on_form_filled'
      end
    else
      # no consultations from this user found. start a new consultation
      render 'index'
    end
  end

  def index_page
    # unregister, if any previous consultation exists
    unregister_consultation
    # start a new consultation
    render 'index'
  end

  def initiate
    Rails.logger.info 'Consultation Controller: Continuing existing consultation'
    # fetch the previous consultation and continue it
    @consultation = Consultation.find(params[:id])
    params[:condition] = @consultation.category
    register_consultation @consultation
    redirect_to params[:link]
  end

  def consultation_form
    if params[:condition]
      session[:condition] = @condition = params[:condition]
      create unless current_consultation.present?
    else
      redirect_to :new_patient_path
    end
    typeform = {
      "Acne" => "https://remedica.typeform.com/to/Eb3Oby",
      "Hairfall or Hair Thinning" => "https://remedica.typeform.com/to/WqEAeB",
      "Pigmentation and Dark Circles" => "https://remedica.typeform.com/to/RgTtE0",
      "Dandruff" => "https://remedica.typeform.com/to/WqEAeB",
      "Eczema, Psoriasis and Rash" => "https://remedica.typeform.com/to/VuHuwt",
      "Stretch Marks" => "https://remedica.typeform.com/to/lSTMhj",
      "Skin Growth (Moles, Warts)" => "https://remedica.typeform.com/to/qs6Oc7"
    }

    @condition_form = typeform[@condition] << "?mobile=#{current_user.mobile}&name=#{current_user.name}"
    session[:typeform_uid] = typeform[@condition].scan(/\/([\w]*)\?/)[0][0]
    current_consultation.update({category: params[:condition]}) unless params[:condition]==current_consultation.category
  end

  # def welcome
  #   # for choosing a condition from the list
  #   # ui takes care of output
  # end

  def self.latest_order
    @@latest_order = ["payment failed", "paid", "free consultation done", "form filled", "registered"]
  end

  def create
    Rails.logger.info("Consultation Controller: Create new user");
    # check if this patient started a consultation exists in the last ~30 mins
    consultation = Consultation.where(patient_id: current_user.id).where("created_at >= ?", DateTime.now-0.02).order('id desc')
    if consultation.present?

      # get the consultation with latest status from these consultations
      sorted_consultation = consultation.sort_by{|x| ConsultationController.latest_order.index x.user_status}[0]
      @consultation = Consultation.find_by_id sorted_consultation.id
  
      unless @consultation.pay_status == 'paid'
  
        # update consultation details
        @consultation.update({category: @condition})
        consultation_params = {}
        unless session[:promo_code].nil?
          coupon = Coupon.find_by coupon_code: session[:promo_code]
          consultation_params[:amount] = 350 - coupon.discount_amount
          consultation_params[:coupon_id] = coupon.id
        end
  
        @consultation.update(consultation_params)
        register_consultation @consultation
        return
      end
    end
    # no latest unpaid consultation found
    # create new consultation
    consultation_params = {
      patient: current_user,
      category: @condition
    }
    unless session[:promo_code].nil?
      coupon = Coupon.find_by coupon_code: session[:promo_code]
      consultation_params[:amount] = 350 - coupon.discount_amount
      consultation_params[:coupon_id] = coupon.id
    end
    logger.info consultation_params

    @consultation = Consultation.create(consultation_params)
    logger.info @consultation
    register_consultation @consultation

    DeliverMailsWorker.perform_in(1.hours, @consultation.id) if Rails.env.production?
  end
end
