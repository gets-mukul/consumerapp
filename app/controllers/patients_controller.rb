class PatientsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  REMEDICA_PATIENTS_ENDPOINT = Rails.application.secrets.PATIENTS_ENDPOINT
  require 'uri'
  require 'net/http'
  require 'encrypt'

  # POST /patients
  def create
    Rails.logger.info("Patients Controller: Create new patient");
    # check if patient exists in database
    @patient = Patient.find_by_mobile(patient_params[:mobile])
    if @patient
      # patient exists in local database. Log them in
      register @patient
      redirect_to "/consult?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
      # render json: { :message =>"Patient found. Logging in." }, :status => 200
    else
      # patient exists in local database. Store their details
      save_patient
    end
  end

  # GET /patients
  def login_with_coupon
    @coupon = Coupon.find_by coupon_code: params[:promo]
    if @coupon && ((@coupon.count<@coupon.max_count) && (@coupon.expires_on.present? ? Time.new <= @coupon.expires_on : true))
      @coupon.update(status: 'coupon entered')
      session[:coupon_applied] = true
      session[:promo_code] = params[:promo]
    end

    if params[:url]=='patients'
      if params[:p]
        id = decrypt(params[:p], 0)
        redirect_to "/?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query if id.nil?
        @patient = Patient.find_by_id id
      else
        @patient = Patient.find_by_mobile(patient_params[:mobile])
      end
      register @patient
      redirect_to "/consult?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
    elsif params[:url]=='payment'
      redirect_to instant_payment_path(params.permit(:p, :utm_source, :utm_medium, :utm_campaign))
    end
  end

  # POST /patients
  def create_with_coupon
    if params[:coupon] == "SODELHI"

      @coupon = Coupon.find_by coupon_code: session[:promo_code]
      if @coupon
        # check if patient exists in database
        @patient = Patient.find_by_mobile(patient_params[:mobile])
        if @patient
          # patient exists in local database. Log them in
          register @patient
          @coupon.update(status: 'coupon attached')
          logger.info "Patient Controller: free coupon patient #{@patient.name} registered"
          render :json => { :value => "success", :discount_price => 'FREE' }
        else
          # patient exists in local database. Store their details
          save_patient_with_coupon
        end
      else
        # coupon does not exist
        logger.info "Patient Controller: free coupon #{@coupon.coupon_code} does not exist"
        render :json => { :value => "failure" }
      end
    end
  end

  def instant_login
    # decrypt the id
    Rails.logger.info("Patients Controller: Instant login");
    id = decrypt(params[:p], 0)
    logger.info "Patient Controller: instant login with patient id #{id}"
    if id.nil?
      # id does not exist
      redirect_to "/?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
    else
      # id exists, get patient with that id
      @patient = Patient.find_by_id id
      if @patient
        logger.info "Patient Controller: instant login successful for patient id #{id}"
        register @patient
        return redirect_to "/consult?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
      else
        logger.info "Patient Controller: instant login patient does not exist for patient id #{id}"
        redirect_to "/?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
      end
    end
  end

  def set_patient_email
    if current_user && params["email"].present?
      current_user.update({:email => params["email"]})
      render :json => { :value => "success", :email => params["email"] }
    else
      render :json => { :value => "failure" }
    end
  end

  private
    def conditions
      [
        "Acne",
        "Hairfall or Hair Thinning",
        "Pigmentation and Dark Circles",
        "Dandruff",
        "Eczema, Psoriasis and Rash",
        "Stretch Marks",
        "Skin Growth (Moles, Warts)",
        "General Skin Care"
      ]
    end
    # use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def save_patient
      @patient = Patient.new(patient_params)
      if @patient.save
        register @patient
        logger.info "Patient Controller: successfully saved new patient with patient id #{@patient.id}"
        if session[:promo_code].present?
          AdminNotifierMailer.send_new_user_mail(@patient, session[:promo_code]).deliver_later
        else
          AdminNotifierMailer.send_new_user_mail(@patient).deliver_later
        end
        logger.info "Patient Controller: mailed admin details of new patient with patient id #{@patient.id}"
        return redirect_to "/consult?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
        # render json: { :message => "Patient found. Logging in." }, :status => 200
      else
        logger.info "Patient Controller: failed saving new patient with patient id #{@patient.id}"
        return redirect_to "/"
      end
    end

    def save_patient_with_coupon
      @patient = Patient.new(patient_params)
      if @patient.save
        register @patient
        AdminNotifierMailer.send_new_user_mail_with_insta(@patient, params[:insta], session[:promo_code]).deliver_later
        @coupon.update(status: 'coupon attached')
        logger.info "Patient Controller: successfully saved free coupon new patient with patient id #{@patient.id}"
        render :json => { :value => "success", :discount_price => 'FREE' }
      else
        logger.info "Patient Controller: failed saving free coupon new patient with patient id #{@patient.id}"
        render :json => { :value => "failure" }
      end
    end

    # never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      {
        email: params[:email],
        mobile: params[:mobile],
        name: (params[:name] || "").downcase.titleize.strip,
        referrer: params[:referrer]
      }
      # params.require(:patient).permit(:name, :email, :mobile)
    end

    # def patient_exists? mobile
    #   post_params = {
    #                   :phone_no => mobile,
    #                   :token => Rails.application.secrets.REMEDICA_PATIENTS_API_KEY
    #                 }

    #   url = URI.parse(REMEDICA_PATIENTS_ENDPOINT + "/find")
    #   con = Net::HTTP.new(url.host, url.port)
    #   con.use_ssl = true if Rails.env.production?
    #   resp = con.post url.path, post_params.to_query

    #   if resp.kind_of? Net::HTTPFound
    #     true
    #   else
    #     false
    #   end
    # end

    # def send_new_patient_info patient_params
    #   post_params =  {
    #                   :patient =>
    #                     {
    #                       :email => patient_params[:email],
    #                       :mobile => patient_params[:mobile],
    #                       :name => patient_params[:name]
    #                       },
    #                   :token => Rails.application.secrets.REMEDICA_PATIENTS_API_KEY
    #                   }

    #   url = URI.parse(REMEDICA_PATIENTS_ENDPOINT + "/create")
    #   con = Net::HTTP.new(url.host, url.port)
    #   con.use_ssl = true if Rails.env.production?
    #   con.post url.path, post_params.to_query
    # end
end
