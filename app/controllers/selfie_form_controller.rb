class SelfieFormController < ApplicationController
  require 'urlsafe_encrypt'
  skip_before_action :verify_authenticity_token, only: [:create]

  def thank_you
  end

  def create
    Rails.logger.info "Registering selfie user #{params['name']}"

    # check if patient exists
    patient = Patient.where(:mobile => params['mobile']).first_or_create(:name => params['name'].downcase.titleize.strip, :pay_status => 'selfie checkup')

    if patient
      # create a selfie form
      selfie_image = SelfieImage.create({:image => params["file_upload"]})

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
    render :json => { :value => "unable to process" }
  end

  def selfie_diagnosis
    # customer's diagnosis link
    # fetch key from params
    key = params["s"]
    if key
      # if key exists, decrypt the key
      @selfie_form = SelfieForm.find(urlsafe_decrypt(key))
      if @selfie_form
        # if key is valid render the diagnosis page
        @conditions = @selfie_form.conditions.pluck(:inline_desc)
        render 'selfie_diagnosis'
      end
    end
  end
end
