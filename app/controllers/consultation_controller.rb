class ConsultationController < ApplicationController
  before_action :check_current_user

  def index
    @patient = Patient.new
    @condition = session[:condition]
  end

  def consultation_form
    if params[:condition]
      session[:condition] = @condition = params[:condition]
      create
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
  end

  def welcome
  end

  def create

    consultation = Consultation.where(patient_id: current_user.id).where("created_at >= ?", DateTime.now-0.02).order('id desc')

    if consultation.present?
      latest_order = ["payment failed", "paid", "free consultation done", "form filled", "registered"]
      sorted_consultation = consultation.sort_by{|x| latest_order.index x.user_status}[0]
      @consultation = Consultation.find_by_id sorted_consultation.id

      @consultation.update({category: @condition})
      consultation_params = {}
      unless session[:promo_code].nil?
        coupon = Coupon.find_by coupon_code: session[:promo_code]
        consultation_params[:amount] = 350 - coupon.discount_amount
        consultation_params[:coupon_id] = coupon.id
      end

      @consultation.update(consultation_params)
      register_consultation @consultation

    else
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
    UpdateSheetsWorker.perform_in(1.hours) if Rails.env.production?

  end

end
