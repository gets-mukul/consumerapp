class Api::V1::PatientController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  include ExternalConnectionHelper

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
