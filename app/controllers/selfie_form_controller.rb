class SelfieFormController < ApplicationController
  require 'urlsafe_encrypt'
  skip_before_action :verify_authenticity_token, only: [:create_image, :create_patient]

  def thank_you
  end

  def create_image
    Rails.logger.info "SelfieFormController: create_image"

    # create a selfie image
    selfie_image = SelfieImage.new({:image => params[:file_upload]})

    if selfie_image.save and !selfie_image.image.nil?
      session[:selfie_image_id] = selfie_image.id
      render :json => { :value => "success" }
    else
      render :json => { :value => "failure" }
    end
  end

  def create_patient
    Rails.logger.info "SelfieFormController: create_patient with params #{params}"

    # check if patient exists
    patient = Patient.find_by :mobile => params[:mobile]

    if patient
      patient.update({ :email => params[:email].downcase.strip}) if patient.email.blank?
    else
      patient = Patient.create({:name => params[:fullname].downcase.titleize.strip, :mobile => params[:mobile], :email => params[:email].downcase.strip, :pay_status => 'selfie checkup'})
    end

    if patient
      # create a selfie form
      selfie_image = SelfieImage.find(session[:selfie_image_id])

      if selfie_image
        @selfie_form = SelfieForm.new
        @selfie_form.patient = patient
        @selfie_form.selfie_image = selfie_image

        # save
        if @selfie_form.save
          Rails.logger.info @selfie_form
          # register patient
          register_selfie_checkup_user patient
          render :json => { :value => "success" }
          return
        end
      end
    end
    render :json => { :value => "failure" }
  end

  def selfie_diagnosis
    # customer's diagnosis link
    # fetch key from params
    key = params["s"]
    # if key exists, decrypt the key
    if key
      @selfie_form = SelfieForm.find(urlsafe_decrypt(key))
      if @selfie_form
        # if key is valid render the diagnosis page
        @conditions = @selfie_form.conditions.pluck(:inline_desc)
        @login_link = "/consult/patients?name=#{@selfie_form.patient.name}&mobile=#{@selfie_form.patient.mobile}&referrer=SelfieCheckupDiagnosis&utm_source=SelfieCheckupDiagnosis&utm_medium=cpa&utm_campaign=SelfieCheckupDiagnosis"
        render 'selfie_diagnosis'
      end
    end
  end
end
