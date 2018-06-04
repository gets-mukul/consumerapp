class Api::V1::PatientController < Api::V1::ApiController
  # skip_before_action :verify_authenticity_token


  def create
    # check if patient exists in database
    @patient = Patient.find_by_mobile(patient_params[:mobile])

    unless @patient
      # patient does not exist
      # create and send admin notifier mail
      @patient = Patient.new(patient_params)
      if @patient.save
        AdminNotifierMailer.send_new_user_mail(@patient, (session[:promo_code] || '') ).deliver_later
      else
        render json: @patient.errors, status: :unprocessable_entity
        return
      end
    end

    register @patient
    Rails.logger.info '----------- registered patient'
    Rails.logger.info session['user_id']

    render json: fetch_consultations, status: :ok
  end

  # never trust parameters from the scary internet, only allow the white list through.
  def patient_params
    {
      email: params[:email],
      mobile: params[:mobile],
      name: (params[:name] || "").downcase.titleize.strip,
      referrer: params[:referrer]
    }
    # params.permit(:name, :email, :mobile, :referrer)
  end

  def unregister_patient
    unregister
    render json: { status: 'unregistered' }, status: :ok
  end

end
