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

  def create
    unless params[:imageUrl].present? and params[:patient][:fullname].present? and params[:patient][:mobile].present? and params[:patient][:email].present?
      render :json => { :message => 'required fields are empty' }, :status => :bad_request
      return
    end

    # check if patient with given details exists patient
    patient = Patient.find_by :mobile => params[:patient][:mobile]

    # if patient exists, update their details, else create
    if patient
      patient.update({ :email => params[:patient][:email].downcase.strip}) if patient.email.blank?
    else
      patient = Patient.create({
        :name => params[:patient][:fullname].downcase.titleize.strip, 
        :mobile => params[:patient][:mobile], 
        :email => params[:patient][:email].downcase.strip, 
        :pay_status => 'selfie checkup',
      })
    end

    # create selfie form for patient with the given image
    if patient
      # create selfie image
      selfie_image = SelfieImage.new({:image => params[:imageUrl]})
      # create selfie form
      selfie_form = SelfieForm.new({ :patient => patient, :selfie_image => selfie_image })

      if params[:skinTypeQuiz].present?
        save_my_skin_type(params[:skinTypeQuiz], patient)
      end

      # save
      if selfie_form.save
        # register patient
        register_selfie_checkup_user patient
        render :json => { :message => 'successful' }, :status => :created
        return
      end
    end

    render :json => { :message => 'failed to upload' }, :status => :bad_request
  end

  def get_skin_type_quiz
    quiz = SimpleQuiz.find_by :content_type => "skin type quiz"
    if quiz
      render :json => { :questions => quiz.questions }, :status => :ok
    else
      render :json => { :message => 'failed' }, :status => :not_found
    end
  end

  private
    def save_my_skin_type(options, user)
      choices = {0 => "oily", 1 => "dry", 2 => "combination", 3 => "senstitive", 4 => "normal"}
      types = []

      options[:questions].each do |question|
        types.push(choices[question["options"].find_index(options[:responses][question["question"]])])
      end
      classes = {["oily", "oily", "oily", "oily", "oily"]=>"oily", ["oily", "oily", "oily", "oily", "dry"]=>"oily",["oily", "oily", "oily", "oily", "combination"]=>"oily", ["oily", "oily", "oily", "oily", "sensitive"]=>"oily sensitive", ["oily", "oily", "oily", "oily", "normal"]=>"oily", ["oily", "oily", "oily", "dry", "dry"]=>"combination", ["oily", "oily", "oily", "dry", "combination"]=>"combination", ["oily", "oily", "oily", "dry", "sensitive"]=>"combination sensitive", ["oily", "oily", "oily", "dry", "normal"]=>"combination", ["oily", "oily", "oily", "combination", "combination"]=>"combination", ["oily", "oily", "oily", "combination", "sensitive"]=>"combination sensitive", ["oily", "oily", "oily", "combination", "normal"]=>"combination", ["oily", "oily", "oily", "sensitive", "sensitive"]=>"oily sensitive", ["oily", "oily", "oily", "sensitive", "normal"]=>"oily sensitive",["oily", "oily", "oily", "normal", "normal"]=>"oily",["oily", "oily", "dry", "dry", "dry"]=>"combination", ["oily", "oily", "dry", "dry", "combination"]=>"combination", ["oily", "oily", "dry", "dry", "sensitive"]=>"combination sensitive", ["oily", "oily", "dry", "dry", "normal"]=>"combination",["oily", "oily", "dry", "combination", "combination"]=>"combination",["oily", "oily", "dry", "combination", "sensitive"]=>"combination sensitive", ["oily", "oily", "dry", "combination", "normal"]=>"combination",["oily", "oily", "dry", "sensitive", "sensitive"]=>"combination sensitive", ["oily", "oily", "dry", "sensitive", "normal"]=>"combination sensitive", ["oily", "oily", "dry", "normal", "normal"]=>"combination",["oily", "oily", "combination", "combination", "combination"]=>"combination", ["oily", "oily", "combination", "combination", "sensitive"]=>"combination sensitive",["oily", "oily", "combination", "combination", "normal"]=>"combination", ["oily", "oily", "combination", "sensitive", "sensitive"]=>"combination sensitive", ["oily", "oily", "combination", "sensitive", "normal"]=>"combination sensitive",["oily", "oily", "combination", "normal", "normal"]=>"combination", ["oily", "oily", "sensitive", "sensitive", "sensitive"]=>"oily sensitive", ["oily", "oily", "sensitive", "sensitive", "normal"]=>"oily sensitive",["oily", "oily", "sensitive", "normal", "normal"]=>"oily sensitive",["oily", "oily", "normal", "normal", "normal"]=>"normal to oily",["oily", "dry", "dry", "dry", "dry"]=>"dry",["oily", "dry", "dry", "dry", "combination"]=>"combination",["oily", "dry", "dry", "dry", "sensitive"]=>"combination sensitive",["oily", "dry", "dry", "dry", "normal"]=>"combination",["oily", "dry", "dry", "combination", "combination"]=>"combination",["oily", "dry", "dry", "combination", "sensitive"]=>"combination sensitive", ["oily", "dry", "dry", "combination", "normal"]=>"combination",["oily", "dry", "dry", "sensitive", "sensitive"]=>"combination sensitive", ["oily", "dry", "dry", "sensitive", "normal"]=>"combination sensitive", ["oily", "dry", "dry", "normal", "normal"]=>"combination",["oily", "dry", "combination", "combination", "combination"]=>"combination",["oily", "dry", "combination", "combination", "sensitive"]=>"combination sensitive", ["oily", "dry", "combination", "combination", "normal"]=>"combination",["oily", "dry", "combination", "sensitive", "sensitive"]=>"combination sensitive", ["oily", "dry", "combination", "sensitive", "normal"]=>"combination sensitive", ["oily", "dry", "combination", "normal", "normal"]=>"combination",["oily", "dry", "sensitive", "sensitive", "sensitive"]=>"combination sensitive", ["oily", "dry", "sensitive", "sensitive", "normal"]=>"combination sensitive", ["oily", "dry", "sensitive", "normal", "normal"]=>"combination sensitive", ["oily", "dry", "normal", "normal", "normal"]=>"combination",["oily", "combination", "combination", "combination", "combination"]=>"combination",["oily", "combination", "combination", "combination", "sensitive"]=>"combination sensitive", ["oily", "combination", "combination", "combination", "normal"]=>"combination",["oily", "combination", "combination", "sensitive", "sensitive"]=>"combination sensitive", ["oily", "combination", "combination", "sensitive", "normal"]=>"combination sensitive", ["oily", "combination", "combination", "normal", "normal"]=>"combination",["oily", "combination", "sensitive", "sensitive", "sensitive"]=>"combination sensitive",["oily", "combination", "sensitive", "sensitive", "normal"]=>"combination sensitive", ["oily", "combination", "sensitive", "normal", "normal"]=>"combination sensitive", ["oily", "combination", "normal", "normal", "normal"]=>"combination",["oily", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive",["oily", "sensitive", "sensitive", "sensitive", "normal"]=>"sensitive",["oily", "sensitive", "sensitive", "normal", "normal"]=>"sensitive",["oily", "sensitive", "normal", "normal", "normal"]=>"sensitive",["oily", "normal", "normal", "normal", "normal"]=>"normal",["dry", "dry", "dry", "dry", "dry"]=>"dry",["dry", "dry", "dry", "dry", "combination"]=>"dry",["dry", "dry", "dry", "dry", "sensitive"]=>"dry sensitive",["dry", "dry", "dry", "dry", "normal"]=>"dry",["dry", "dry", "dry", "combination", "combination"]=>"combination",["dry", "dry", "dry", "combination", "sensitive"]=>"combination sensitive", ["dry", "dry", "dry", "combination", "normal"]=>"combination",["dry", "dry", "dry", "sensitive", "sensitive"]=>"dry sensitive",["dry", "dry", "dry", "sensitive", "normal"]=>"dry sensitive",["dry", "dry", "dry", "normal", "normal"]=>"dry",["dry", "dry", "combination", "combination", "combination"]=>"combination",["dry", "dry", "combination", "combination", "sensitive"]=>"combination sensitive", ["dry", "dry", "combination", "combination", "normal"]=>"combination",["dry", "dry", "combination", "sensitive", "sensitive"]=>"combination sensitive", ["dry", "dry", "combination", "sensitive", "normal"]=>"combination sensitive", ["dry", "dry", "combination", "normal", "normal"]=>"combination",["dry", "dry", "sensitive", "sensitive", "sensitive"]=>"dry sensitive", ["dry", "dry", "sensitive", "sensitive", "normal"]=>"dry sensitive",["dry", "dry", "sensitive", "normal", "normal"]=>"dry sensitive",["dry", "dry", "normal", "normal", "normal"]=>"normal to dry",["dry", "combination", "combination", "combination", "combination"]=>"combination", ["dry", "combination", "combination", "combination", "sensitive"]=>"combination sensitive", ["dry", "combination", "combination", "combination", "normal"]=>"combination", ["dry", "combination", "combination", "sensitive", "sensitive"]=>"combination sensitive", ["dry", "combination", "combination", "sensitive", "normal"]=>"combination sensitive", ["dry", "combination", "combination", "normal", "normal"]=>"combination", ["dry", "combination", "sensitive", "sensitive", "sensitive"]=>"dry sensitive",  ["dry", "combination", "sensitive", "sensitive", "normal"]=>"combination sensitive", ["dry", "combination", "sensitive", "normal", "normal"]=>"combination sensitive", ["dry", "combination", "normal", "normal", "normal"]=>"combination", ["dry", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["dry", "sensitive", "sensitive", "sensitive", "normal"]=>"sensitive", ["dry", "sensitive", "sensitive", "normal", "normal"]=>"sensitive", ["dry", "sensitive", "normal", "normal", "normal"]=>"sensitive", ["dry", "normal", "normal", "normal", "normal"]=>"normal", ["combination", "combination", "combination", "combination", "combination"]=>"combination", ["combination", "combination", "combination", "combination", "sensitive"]=>"combination sensitive", ["combination", "combination", "combination", "combination", "normal"]=>"combination", ["combination", "combination", "combination", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "combination", "combination", "sensitive", "normal"]=>"combination sensitive", ["combination", "combination", "combination", "normal", "normal"]=>"combination", ["combination", "combination", "sensitive", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "combination", "sensitive", "sensitive", "normal"]=>"combination sensitive", ["combination", "combination", "sensitive", "normal", "normal"]=>"combination sensitive", ["combination", "combination", "normal", "normal", "normal"]=>"combination", ["combination", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["combination", "sensitive", "sensitive", "sensitive", "normal"]=>"sensitive", ["combination", "sensitive", "sensitive", "normal", "normal"]=>"combination sensitive", ["combination", "sensitive", "normal", "normal", "normal"]=>"combination sensitive", ["combination", "normal", "normal", "normal", "normal"]=>"normal", ["sensitive", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["sensitive", "sensitive", "sensitive", "sensitive", "normal"]=>"sensitive", ["sensitive", "sensitive", "sensitive", "normal", "normal"]=>"sensitive", ["sensitive", "sensitive", "normal", "normal", "normal"]=>"sensitive", ["sensitive", "normal", "normal", "normal", "normal"]=>"normal", ["normal", "normal", "normal", "normal", "normal"]=>"normal"}

      diagnosis = Diagnosis.find_by(sub_category: classes[types], category: "skin type quiz")
      simple_quiz_response = SimpleQuizResponse.new(:patient => user, :diagnosis => diagnosis, :responses => options[:responses], :simple_quiz => (SimpleQuiz.find_by :content_type => "skin type quiz"))
      simple_quiz_response.save!
    end

end
