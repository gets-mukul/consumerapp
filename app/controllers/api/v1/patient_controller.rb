class Api::V1::PatientController < Api::V1::ApiController
  # skip_before_action :verify_authenticity_token
  skip_before_action :verify_authenticity_token
  include ExternalConnectionHelper


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
        render json: @patient.errors, status: :unprocessable_entity and return
      end
    end

    register @patient
    render json: @patient, :only => [:name], status: :ok
    # render json: fetch_consultations, status: :ok
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


  def get_patient_details
    query_cmd = ''

    if params['key']==Rails.application.secrets.GOOGLE_CONTACTS_APP_SCRIPTS
      case params['type']
      when 'all'
        query_cmd = "select id, name, mobile, email, COALESCE(to_char(created_at, 'YYYYMMDD'), '') AS created_at from patients where id > " + params['start']
      when 'all_status'
        query_cmd = "select distinct on (p.id) p.id as pid, p.name, p.mobile, p.email, COALESCE(to_char(p.created_at, 'YYYYMMDD'), '') AS created_at, c.user_status from patients p left join consultations c on p.id=c.patient_id where p.id > " + params['start'] + " and p.id <= " + params['stop'] + " order by p.id desc, c.id desc;"
      when 'all_paid'
        query_cmd = "select distinct on (p.id) p.name, p.mobile, p.email from patients p left join consultations c on p.id=c.patient_id where c.pay_status like 'paid' and EXTRACT(YEAR FROM p.created_at) = " + params['year'] + " order by p.id desc, c.id desc;"
      end

      if query_cmd.present?
        with_external_db do
          render :json => {"status": "ok", "code": 200, "messages": [], "result": ActiveRecord::Base.connection.execute(query_cmd).values }
          return
        end
      end
    end
    Rails.logger.info '------------- finished rendering contacts -----------'
    render :json => {"status": "Unauthorized", "code": 401}
  end

end
