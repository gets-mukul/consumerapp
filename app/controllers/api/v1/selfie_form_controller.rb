class Api::V1::SelfieFormController < Api::V1::ApiController

  # SelfieForm2 = Struct.new(:doctor, :patient)
  # Doctor2 = Struct.new(:code, :full_name)
  # Patient2 = Struct.new(:name)

  def get_diagnosis

    # customer's diagnosis link
    # fetch key from params
    key = params["selfie_id"]
    # if key exists, decrypt the key
    if key
      selfie_form = SelfieForm.find(urlsafe_decrypt(key))
      if selfie_form
        register_selfie_checkup_user selfie_form.patient
        # if key is valid render the diagnosis page
        conditions = selfie_form.conditions.select(:key, :title, :inline_desc, :desc)
        inline_descriptors = conditions.collect(&:inline_desc)
        login_link = "/consult/patients?name=#{selfie_form.patient.name}&mobile=#{selfie_form.patient.mobile}&referrer=SelfieCheckupDiagnosis&utm_source=SelfieCheckupDiagnosis&utm_medium=cpa&utm_campaign=SelfieCheckupDiagnosis"

        inline_description = ''
        description = ''
        if (['acne', 'acne excorie'] - conditions.pluck(:title)).empty?
          inline_descriptors.delete_at inline_descriptors.index('<b><i>acne vulgaris</i></b>, commonly known as acne')
        end
        inline_description = 'It seems that you may have ' + (inline_descriptors.length < 3 ? inline_descriptors.to_sentence(:two_words_connector => ', as well as ').html_safe : inline_descriptors[2..-1].unshift((inline_descriptors[0..1].to_sentence(:two_words_connector => ', as well as '))).to_sentence(:words_connector => ', ', :last_word_connector => ', and ')) + '.'

        if conditions.length==1
          description += conditions[0].desc
        else
          if (['acne', 'acne excorie'] - conditions.collect(&:title)).empty?

            (conditions.reject { |c| ['acne', 'acne excorie'].include? c.title }).each do |condition|
              description += '<div class="condition-title">About ' + condition.title + '</div>' + condition.desc
            end

            (conditions.select { |c| c.title=='acne excorie' }).each do |condition|
              description += '<div class="condition-title">About ' + condition.title + '</div>' + condition.desc
            end

          elsif (['acne', 'truncal acne'] - conditions.collect(&:title)).empty?
            (conditions.reject { |c| ['acne', 'truncal acne'].include? c.title }).each do |condition|
              description += '<div class="condition-title">About '+condition.title+ '</div>' + condition.desc
            end
            (conditions.select { |c| c.title=='acne' }).each do |condition|
              description += '<div class="condition-title">About '+ condition.title + '</div>' + condition.desc
            end

            (conditions.select { |c| c.title=='truncal acne' }).each do |condition|
              description += condition.desc.split("\n").last
            end
          else
            conditions.each do |condition|
              description += ('<div class="condition-title">About ' + condition.title + '</div>' + condition.desc)
            end
          end
        end

        render json: { 
          status: 'selfie found', 
          diagnosis: {
            inline_description: inline_description,
            login_link: login_link,
            description: description,
            selfie_form: {
              doctor: {
                code: selfie_form.doctor.code,
                full_name: selfie_form.doctor.full_name,
              },
              patient: {
                name: selfie_form.patient.name,
              }
            }
          }
        }, status: :found
        return
      end
    end
    render json: { status: 'selfie not found' }, status: :not_found  
    rescue ActiveRecord::RecordNotFound
      render json: { status: 'selfie not found' }, status: :not_found  
  end
end
