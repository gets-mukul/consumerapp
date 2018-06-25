class Api::V1::SelfieFormController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

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

        diagnosis = {
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
          },
        }

        simple_quiz_response = SimpleQuizResponse.find_by :patient => selfie_form.patient
        if simple_quiz_response
          diagnosis["skin_type_quiz"] = {
            description: simple_quiz_response.diagnosis.content,
            category: simple_quiz_response.diagnosis.sub_category
          }
        end

        render json: {
          status: 'selfie found',
          diagnosis: diagnosis
        }, status: :found
        return
      end
    end
    render json: { status: 'selfie not found' }, status: :not_found  
    rescue ActiveRecord::RecordNotFound
      render json: { status: 'selfie not found' }, status: :not_found  
  end

  def save_my_skin_type
    types = Array.new(5, [])
    quiz = params["questions"].to_h.map {|x| x[1] }
    quiz.each do |element|
      element["options"].each_with_index do |option, id|
        types[id] |= [option]
      end
    end

    max_values = { :id => 0, :value => 0}

    types.each_with_index do |type, id|
      len = (type & params[:responses].values).length
      max_values = { :id => id, :value => len} if len > max_values[:value]
    end

    diagnosis = nil

    case max_values[:id]
    when 0
      diagnosis = Diagnosis.find_by(sub_category: "Oily Scalp/Oily hair", category: "skin type quiz")
    when 1
      diagnosis = Diagnosis.find_by(sub_category: "Dry Skin", category: "skin type quiz")
    when 2
      diagnosis = Diagnosis.find_by(sub_category: "Combination Skin", category: "skin type quiz")
    when 3
      diagnosis = Diagnosis.find_by(sub_category: "Sensitive Skin", category: "skin type quiz")
    when 4
      diagnosis = Diagnosis.find_by(sub_category: "Normal Skin", category: "skin type quiz")
    end

    simple_quiz_response = SimpleQuizResponse.new(:patient => current_user, :diagnosis => diagnosis, :responses => params[:responses], :simple_quiz => (SimpleQuiz.find_by :content_type => "skin type quiz"))
    simple_quiz_response.save!

    render json: { value: 'success', params: params }, status: :ok
  end
end
