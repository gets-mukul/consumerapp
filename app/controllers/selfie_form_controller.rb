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
      Rails.logger.debug "SelfieImage: Image upload failed."
      render :json => { :value => "failure" }
    end
  end

  def create_patient
    Rails.logger.info "SelfieFormController: create_patient with params #{params}"

    unless session[:selfie_image_id]
      render :json => { :value => "failure" }
      return
    end

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

        @selfie_form = SelfieForm.where(patient_id: patient.id).where("created_at >= ?", DateTime.now-0.004).order('id desc').first
        @selfie_form = SelfieForm.new if @selfie_form.nil?

        @selfie_form.patient = patient
        @selfie_form.selfie_image = selfie_image

        # save
        if @selfie_form.save
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
    redirect_to "/selfie-diagnosis?s=#{params[:s]}"
    return
    # customer's diagnosis link
    # fetch key from params
    key = params["s"]
    # if key exists, decrypt the key
    if key
      @selfie_form = SelfieForm.find(urlsafe_decrypt(key))
      if @selfie_form
        register_selfie_checkup_user @selfie_form.patient
        # if key is valid render the diagnosis page
        @conditions = @selfie_form.conditions.select(:key, :title, :inline_desc, :desc)
        @inline_descriptors = @conditions.collect(&:inline_desc)

        @login_link = "/consult/patients?name=#{@selfie_form.patient.name}&mobile=#{@selfie_form.patient.mobile}&referrer=SelfieCheckupDiagnosis&utm_source=SelfieCheckupDiagnosis&utm_medium=cpa&utm_campaign=SelfieCheckupDiagnosis"

        @inline_description = ''
        @description = ''

        if (['acne', 'acne excorie'] - @conditions.pluck(:title)).empty?
          @inline_descriptors.delete_at @inline_descriptors.index('<b><i>acne vulgaris</i></b>, commonly known as acne')
        end
        @inline_description = 'It seems that you may have ' + (@inline_descriptors.length < 3 ? @inline_descriptors.to_sentence(:two_words_connector => ', as well as ').html_safe : @inline_descriptors[2..-1].unshift((@inline_descriptors[0..1].to_sentence(:two_words_connector => ', as well as '))).to_sentence(:words_connector => ', ', :last_word_connector => ', and ')) + '.'

        if @conditions.length==1
          @description += @conditions[0].desc
        else
          if (['acne', 'acne excorie'] - @conditions.collect(&:title)).empty?

            (@conditions.reject { |c| ['acne', 'acne excorie'].include? c.title }).each do |condition|
              @description += '<div class="condition-title">About ' + condition.title + '</div>' + condition.desc
            end

            (@conditions.select { |c| c.title=='acne excorie' }).each do |condition|
              @description += '<div class="condition-title">About ' + condition.title + '</div>' + condition.desc
            end

          elsif (['acne', 'truncal acne'] - @conditions.collect(&:title)).empty?
            (@conditions.reject { |c| ['acne', 'truncal acne'].include? c.title }).each do |condition|
              @description += '<div class="condition-title">About '+condition.title+ '</div>' + condition.desc
            end
            (@conditions.select { |c| c.title=='acne' }).each do |condition|
              @description += '<div class="condition-title">About '+ condition.title + '</div>' + condition.desc
            end

            (@conditions.select { |c| c.title=='truncal acne' }).each do |condition|
              @description += condition.desc.split("\n").last
            end
          else
            @conditions.each do |condition|
              @description += ('<div class="condition-title">About ' + condition.title + '</div>' + condition.desc)
            end
          end
        end

        render 'selfie_diagnosis'
      end
    end
  end

end
