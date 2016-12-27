class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  REMEDICA_PATIENTS_ENDPOINT = Rails.application.secrets.PATIENTS_ENDPOINT
  require 'uri'
  require 'net/http'

  # POST /patients
  def create
    # Check if patient exists in database
    @patient = Patient.find_by_email(patient_params[:email])
    if @patient
      # Patient exists in local database. Log them in
      register @patient
      render json: { :message =>"Patient found. Logging in." }, :status => 200
    else
      # If they don't, check remote database for
      # cases when remote database is updated and local isn't.
      result = patient_exists? params[:patient][:email]

      if result
        # Patient exists in remote database.
        save_patient
      else
        # New Patient, update both local and remote databases.
        resp, data = send_new_patient_info patient_params

        if !resp.kind_of? Net::HTTPOK
          render json: { :error => "An error ocurred. Please try again later." }, status: :unprocessable_entity
        else
          # Patient saved at remote database. We can start saving it at local as well.
          save_patient
        end
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def save_patient
      @patient = Patient.new(patient_params)
      respond_to do |format|
        if @patient.save
          register @patient
          format.json { render json: { :message => "Patient found. Logging in." }, :status => 200}
        else
          format.json { render json: @patient.errors, status: :unprocessable_entity }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :email, :mobile)
    end

    def patient_exists? email
      post_params = {
                      :email => email,
                      :token => Rails.application.secrets.REMEDICA_PATIENTS_API_KEY
                    }

      url = URI.parse(REMEDICA_PATIENTS_ENDPOINT + "/find")
      con = Net::HTTP.new(url.host, url.port)
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
      con.post url.path, post_params.to_query
    end
end
