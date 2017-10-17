require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Google Sheets API Ruby Quickstart'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                             "sheets.googleapis.com-ruby-quickstart.yaml")
SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(
    client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(
      base_url: OOB_URI)
    puts "Open the following URL in the browser and enter the " +
         "resulting code after authorization"
    puts url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
  end
  credentials
end

def update_sheet

  # Initialize the API
  service = Google::Apis::SheetsV4::SheetsService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize

  spreadsheet_id = '1CvkpikWLZS99FqavGiQKDO4IJ1vI7Ilb9a_kEBOmYAE'
  range = 'User Data!A2'

  patients = Patient.all.order('id asc').pluck(:id, :created_at, :updated_at, :name, :mobile, :email, :referrer)

  value_range_object = {
    major_dimension: "ROWS",
    values: patients
  }

  update_res = service.update_spreadsheet_value(spreadsheet_id, range, value_range_object, value_input_option: 'USER_ENTERED')

  consultations = Consultation.joins('LEFT OUTER JOIN patient_sources on patient_sources.consultation_id=consultations.id').joins('LEFT JOIN patients on consultations.patient_id=patients.id').joins('LEFT OUTER JOIN coupons on consultations.coupon_id=coupons.id').select('distinct on (consultations.id) consultations.id, patients.id, patients.name, patients.mobile, coupons.coupon_code, consultations.category, consultations.user_status, consultations.pay_status, consultations.created_at, patient_sources.local_referrer, patient_sources.utm_campaign').order('consultations.id asc')

  consultation_list = consultations.pluck(:id, :patient_id, :name, :mobile, :coupon_code, :category, :user_status, :pay_status, :created_at, :local_referrer, :utm_campaign)

  range = 'Consultations!A2'

  value_range_object = {
    major_dimension: "ROWS",
    values: consultation_list
  }

  update_res = service.update_spreadsheet_value(spreadsheet_id, range, value_range_object, value_input_option: 'USER_ENTERED')

end

