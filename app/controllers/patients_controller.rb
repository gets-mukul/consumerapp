class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  REMEDICA_PATIENTS_ENDPOINT = Rails.application.secrets.PATIENTS_ENDPOINT
  require 'uri'
  require 'net/http'

  # POST /patients
  def create
    result = patient_exists? params[:patient][:email]
    if result.first
      @patient = Patient.new(result.second)
      register @patient
      respond_to do |format|
        format.json { render json: "Patient found. Logging in." }
      end
    else
      resp, data = send_new_patient_info patient_params

      if !resp.kind_of? Net::HTTPOK
        respond_to do |format|
          format.json { render json: data[:error], status: :unprocessable_entity }
        end
      else
        @patient = Patient.new(patient_params)
        respond_to do |format|
          if @patient.save
            register @patient
            format.json { render json: "Patient was successfully created." }
          else
            format.json { render json: @patient.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
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
      json = JSON.parse(resp.body)

      if resp.kind_of? Net::HTTPFound
        [true, json["patient"].to_a.take(4).to_h]
      else
        [false]
      end
    end

    def send_new_patient_info patient_params
      post_params =  {
                      :email => patient_params[:email],
                      :mobile => patient[:mobile],
                      :name => patient[:name],
                      :token => Rails.application.secrets.REMEDICA_PATIENTS_API_KEY
                      }

      url = URI.parse(REMEDICA_PATIENTS_ENDPOINT + "/create")
      con = Net::HTTP.new(url.host, url.port)
      con.post url.path, post_params.to_query
    end
end
