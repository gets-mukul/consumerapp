class SelfieFormController < ApplicationController
  require 'urlsafe_encrypt'

  def thank_you
  end

  def create
    Rails.logger.info "Registering selfie user #{params['name']}"

    # check if patient exists
    patient = Patient.where(:mobile => params['mobile']).first_or_create(:name => params['name'].downcase.titleize.strip,)
    if patient
      # create a selfie form
      @selfie_form = SelfieForm.new
      @selfie_form.image = params["image"]
      @selfie_form.patient = patient

      # save
      if @selfie_form.save
        Rails.logger.info @selfie_form
        # register patient
        register_selfie_checkup_user patient
        redirect_to :action => "thank_you"
        return
      end
    end
    render "new"
  end

  def selfie_diagnosis
    # customer's diagnosis link
    # fetch key from params
    mkey = params["key"]
    if mkey
      # if key exists, decrypt the key
      @selfie_form = SelfieForm.find(urlsafe_decrypt(mkey))
      if @selfie_form
        # if key is valid render the diagnosis page
        @conditions = @selfie_form.conditions.pluck(:inline_desc)
        render 'selfie_diagnosis'
      end
    end
  end
end