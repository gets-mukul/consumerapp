class PatientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  REMEDICA_PATIENTS_ENDPOINT = Rails.application.secrets.PATIENTS_ENDPOINT
  require 'uri'
  require 'net/http'
  require 'encrypt'

  # POST /patients
  def create
    # Check if patient exists in database
    @patient = Patient.find_by_mobile(patient_params[:mobile])
    if @patient
      # Patient exists in local database. Log them in
      register @patient
      redirect_to "/consult"
      # render json: { :message =>"Patient found. Logging in." }, :status => 200
    else
      # If they don't, check remote database for
      # cases when remote database is updated and local isn't.
      save_patient
      
      # result = patient_exists? patient_params[:mobile]
      # if result
      #   # Patient exists in remote database.
      #   save_patient
      # else
      #   # New Patient, update both local and remote databases.
      #   resp, data = send_new_patient_info patient_params
      #   if !resp.kind_of? Net::HTTPOK
      #     logger.debug resp.body
      #     # save_patient
      #     redirect_to "/"
      #     # render json: { :error => "An error ocurred. Please try again later." }, status: :unprocessable_entity
      #   else
      #     # Patient saved at remote database. We can start saving it at local as well.
      #     save_patient
      #   end
      # end
      
    end
  end

  # POST /patients
  def create_with_coupon
    if params[:coupon] == "SODELHI"

      @coupon = Coupon.find_by coupon_code: session[:promo_code]

      if @coupon
        # Check if patient exists in database
        @patient = Patient.find_by_mobile(patient_params[:mobile])
        if @patient
          # Patient exists in local database. Log them in
          register @patient
          @coupon.update(status: 'coupon attached')

          logger.info 'RETURN SUCCESS'
          render :json => { :value => "success", :discount_price => 'FREE' }
          # redirect_to "/?applied=FREE"
        else
          # If they don't, check remote database for
          # cases when remote database is updated and local isn't.
          save_patient_with_coupon
          
          # result = patient_exists? patient_params[:mobile]
          # if result
          #   # Patient exists in remote database.
          #   save_patient_with_coupon
          # else
          #   # New Patient, update both local and remote databases.
          #   resp, data = send_new_patient_info patient_params
          #   if !resp.kind_of? Net::HTTPOK
          #     logger.debug resp.body
          #     logger.info 'RETURN FAILURE'
          #     render :json => { :value => "failure" }
          #     # redirect_to "/?applied=false"
          #     # redirect_to "/"
          #     # render json: { :error => "An error ocurred. Please try again later." }, status: :unprocessable_entity
          #   else
          #     # Patient saved at remote database. We can start saving it at local as well.
          #     save_patient_with_coupon
          #   end
          # end
          
        end
      else
        logger.info 'NOT EXISTS'
        render :json => { :value => "failure" }
        # redirect_to "/?applied=false"
      end
    end
  end

  def instant_login
    id = decrypt(params[:p], 0)
    logger.info "ID INSTANT LOGIN"
    logger.info id
    if id.nil?
      redirect_to "/"
    else
      @patient = Patient.find_by_id id
      if @patient
        register @patient
        return redirect_to "/consult"
      else
        redirect_to "/"
      end
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
        "Skin Growth (Moles, Warts)"
      ]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def save_patient
      @patient = Patient.new(patient_params)
      if @patient.save
        register @patient
        if session[:promo_code].present?
          NewUserNotifierMailer.send_new_user_mail(@patient, session[:promo_code]).deliver_later
        else
          NewUserNotifierMailer.send_new_user_mail(@patient).deliver_later
        end
        
        return redirect_to "/consult"
        # render json: { :message => "Patient found. Logging in." }, :status => 200
      else
        # render json: @patient.errors, status: :unprocessable_entity
        return redirect_to "/"
      end
    end

    def save_patient_with_coupon
      @patient = Patient.new(patient_params)
      if @patient.save
        register @patient
        NewUserNotifierMailer.send_new_user_mail_with_insta(@patient, params[:insta], session[:promo_code]).deliver_later
        @coupon.update(status: 'coupon attached')
        logger.info 'RETURN SUCCESS'
        render :json => { :value => "success", :discount_price => 'FREE' }
        # redirect_to "/?applied=FREE"
        # return redirect_to "/consult"
        # render json: { :message => "Patient found. Logging in." }, :status => 200
      else
        # render json: @patient.errors, status: :unprocessable_entity
        logger.info 'RETURN FAILURE'
        render :json => { :value => "failure" }
        # redirect_to "/?applied=false"
        # return redirect_to "/"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      {
        email: params[:email],
        mobile: params[:mobile],
        name: params[:name].downcase.titleize,
        referrer: params[:referrer]
      }
      # params.require(:patient).permit(:name, :email, :mobile)
    end

    def patient_exists? mobile
      post_params = {
                      :phone_no => mobile,
                      :token => Rails.application.secrets.REMEDICA_PATIENTS_API_KEY
                    }

      url = URI.parse(REMEDICA_PATIENTS_ENDPOINT + "/find")
      con = Net::HTTP.new(url.host, url.port)
      con.use_ssl = true if Rails.env.production?
      resp = con.post url.path, post_params.to_query

      if resp.kind_of? Net::HTTPFound
        true
      else
        false
      end
    end

    def send_new_patient_info patient_params
      post_params =  {
                      :patient =>
                        {
                          :email => patient_params[:email],
                          :mobile => patient_params[:mobile],
                          :name => patient_params[:name]
                          },
                      :token => Rails.application.secrets.REMEDICA_PATIENTS_API_KEY
                      }

      url = URI.parse(REMEDICA_PATIENTS_ENDPOINT + "/create")
      con = Net::HTTP.new(url.host, url.port)
      con.use_ssl = true if Rails.env.production?
      con.post url.path, post_params.to_query
    end
end


post_params = {
  :phone_no => "9999999990",
  :token => "a6kxpBwYXpHRPxHEpKCTWFJlbWVkaWNhIFBhdGllbnRzIENvbnRyb2xsZXI"
}

# url = URI.parse("http://127.0.0.1:6536/app/api/patient" + "/find")
url = URI.parse("http://54.255.145.215/app/api/patient" + "/find")
con = Net::HTTP.new(url.host, url.port)
con.use_ssl = true if Rails.env.development?
# con.ssl_version = :SSLv3
resp = con.post url.path, post_params.to_query