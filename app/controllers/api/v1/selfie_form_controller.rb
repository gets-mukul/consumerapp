class Api::V1::SelfieFormController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  after_action :check_for_errors

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
          conditions: conditions.pluck(:key),
          inline_description: inline_description,
          login_link: login_link,
          description: description,
          selfie_form: {
            doctor: {
              code: selfie_form.doctor.code,
              full_name: selfie_form.doctor.full_name,
              qualification: selfie_form.doctor.qualification,
              description: selfie_form.doctor.desc
            },
            patient: {
              name: selfie_form.patient.name,
              sex: selfie_form.patient.sex || '',
              image_url: selfie_form.selfie_image.image
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
    session[:error_msgs] = {}
    unless params[:imageUrl].present? and params[:patient][:fullname].present? and params[:patient][:mobile].present? and params[:patient][:email].present?
      session[:error_msgs]["SelfieForm#create bad request"] = params
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
      else
        session[:error_msgs]["SelfieForm#create could'nt save Selfie_form"] = selfie_form.errors.full_messages.unshift(selfie_form.attributes.to_s)
      end
    else
      session[:error_msgs]["SelfieForm#create could'nt create patient"] = patient.errors.full_messages.unshift(patient.attributes.to_s)
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
      choices = {0 => "oily", 1 => "dry", 2 => "combination", 3 => "sensitive", 4 => "normal"}
      types = []

      options[:questions].each do |question|
        types.push(choices[question["options"].find_index(options[:responses][question["question"]])])
      end
      types.sort!
      classes = {["dry", "oily", "oily", "oily", "oily"]=>"oily", ["combination", "oily", "oily", "oily", "oily"]=>"oily", ["oily", "oily", "oily", "oily", "sensitive"]=>"oily sensitive", ["normal", "oily", "oily", "oily", "oily"]=>"oily", ["dry", "dry", "oily", "oily", "oily"]=>"combination", ["combination", "dry", "oily", "oily", "oily"]=>"combination", ["dry", "oily", "oily", "oily", "sensitive"]=>"combination sensitive", ["dry", "normal", "oily", "oily", "oily"]=>"combination", ["combination", "combination", "oily", "oily", "oily"]=>"combination", ["combination", "oily", "oily", "oily", "sensitive"]=>"combination sensitive", ["combination", "normal", "oily", "oily", "oily"]=>"combination", ["oily", "oily", "oily", "sensitive", "sensitive"]=>"oily sensitive", ["normal", "oily", "oily", "oily", "sensitive"]=>"oily sensitive", ["normal", "normal", "oily", "oily", "oily"]=>"oily", ["dry", "dry", "dry", "oily", "oily"]=>"combination", ["combination", "dry", "dry", "oily", "oily"]=>"combination", ["dry", "dry", "oily", "oily", "sensitive"]=>"combination sensitive", ["dry", "dry", "normal", "oily", "oily"]=>"combination", ["combination", "combination", "dry", "oily", "oily"]=>"combination", ["combination", "dry", "oily", "oily", "sensitive"]=>"combination sensitive", ["combination", "dry", "normal", "oily", "oily"]=>"combination", ["dry", "oily", "oily", "sensitive", "sensitive"]=>"combination sensitive", ["dry", "normal", "oily", "oily", "sensitive"]=>"combination sensitive", ["dry", "normal", "normal", "oily", "oily"]=>"combination", ["combination", "combination", "combination", "oily", "oily"]=>"combination", ["combination", "combination", "oily", "oily", "sensitive"]=>"combination sensitive", ["combination", "combination", "normal", "oily", "oily"]=>"combination", ["combination", "oily", "oily", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "normal", "oily", "oily", "sensitive"]=>"combination sensitive", ["combination", "normal", "normal", "oily", "oily"]=>"combination", ["oily", "oily", "sensitive", "sensitive", "sensitive"]=>"oily sensitive", ["normal", "oily", "oily", "sensitive", "sensitive"]=>"oily sensitive", ["normal", "normal", "oily", "oily", "sensitive"]=>"oily sensitive", ["normal", "normal", "normal", "oily", "oily"]=>"normal to oily", ["dry", "dry", "dry", "dry", "oily"]=>"dry", ["combination", "dry", "dry", "dry", "oily"]=>"combination", ["dry", "dry", "dry", "oily", "sensitive"]=>"combination sensitive", ["dry", "dry", "dry", "normal", "oily"]=>"combination", ["combination", "combination", "dry", "dry", "oily"]=>"combination", ["combination", "dry", "dry", "oily", "sensitive"]=>"combination sensitive", ["combination", "dry", "dry", "normal", "oily"]=>"combination", ["dry", "dry", "oily", "sensitive", "sensitive"]=>"combination sensitive", ["dry", "dry", "normal", "oily", "sensitive"]=>"combination sensitive", ["dry", "dry", "normal", "normal", "oily"]=>"combination", ["combination", "combination", "combination", "dry", "oily"]=>"combination", ["combination", "combination", "dry", "oily", "sensitive"]=>"combination sensitive", ["combination", "combination", "dry", "normal", "oily"]=>"combination", ["combination", "dry", "oily", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "dry", "normal", "oily", "sensitive"]=>"combination sensitive", ["combination", "dry", "normal", "normal", "oily"]=>"combination", ["dry", "oily", "sensitive", "sensitive", "sensitive"]=>"combination sensitive", ["dry", "normal", "oily", "sensitive", "sensitive"]=>"combination sensitive", ["dry", "normal", "normal", "oily", "sensitive"]=>"combination sensitive", ["dry", "normal", "normal", "normal", "oily"]=>"combination", ["combination", "combination", "combination", "combination", "oily"]=>"combination", ["combination", "combination", "combination", "oily", "sensitive"]=>"combination sensitive", ["combination", "combination", "combination", "normal", "oily"]=>"combination", ["combination", "combination", "oily", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "combination", "normal", "oily", "sensitive"]=>"combination sensitive", ["combination", "combination", "normal", "normal", "oily"]=>"combination", ["combination", "oily", "sensitive", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "normal", "oily", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "normal", "normal", "oily", "sensitive"]=>"combination sensitive", ["combination", "normal", "normal", "normal", "oily"]=>"combination", ["oily", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["normal", "oily", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["normal", "normal", "oily", "sensitive", "sensitive"]=>"sensitive", ["normal", "normal", "normal", "oily", "sensitive"]=>"sensitive", ["normal", "normal", "normal", "normal", "oily"]=>"normal", ["dry", "dry", "dry", "dry", "dry"]=>"dry", ["combination", "dry", "dry", "dry", "dry"]=>"dry", ["dry", "dry", "dry", "dry", "sensitive"]=>"dry sensitive", ["dry", "dry", "dry", "dry", "normal"]=>"dry", ["combination", "combination", "dry", "dry", "dry"]=>"combination", ["combination", "dry", "dry", "dry", "sensitive"]=>"combination sensitive", ["combination", "dry", "dry", "dry", "normal"]=>"combination", ["dry", "dry", "dry", "sensitive", "sensitive"]=>"dry sensitive", ["dry", "dry", "dry", "normal", "sensitive"]=>"dry sensitive", ["dry", "dry", "dry", "normal", "normal"]=>"dry", ["combination", "combination", "combination", "dry", "dry"]=>"combination", ["combination", "combination", "dry", "dry", "sensitive"]=>"combination sensitive", ["combination", "combination", "dry", "dry", "normal"]=>"combination", ["combination", "dry", "dry", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "dry", "dry", "normal", "sensitive"]=>"combination sensitive", ["combination", "dry", "dry", "normal", "normal"]=>"combination", ["dry", "dry", "sensitive", "sensitive", "sensitive"]=>"dry sensitive", ["dry", "dry", "normal", "sensitive", "sensitive"]=>"dry sensitive", ["dry", "dry", "normal", "normal", "sensitive"]=>"dry sensitive", ["dry", "dry", "normal", "normal", "normal"]=>"normal to dry", ["combination", "combination", "combination", "combination", "dry"]=>"combination", ["combination", "combination", "combination", "dry", "sensitive"]=>"combination sensitive", ["combination", "combination", "combination", "dry", "normal"]=>"combination", ["combination", "combination", "dry", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "combination", "dry", "normal", "sensitive"]=>"combination sensitive", ["combination", "combination", "dry", "normal", "normal"]=>"combination", ["combination", "dry", "sensitive", "sensitive", "sensitive"]=>"dry sensitive", ["combination", "dry", "normal", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "dry", "normal", "normal", "sensitive"]=>"combination sensitive", ["combination", "dry", "normal", "normal", "normal"]=>"combination", ["dry", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["dry", "normal", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["dry", "normal", "normal", "sensitive", "sensitive"]=>"sensitive", ["dry", "normal", "normal", "normal", "sensitive"]=>"sensitive", ["dry", "normal", "normal", "normal", "normal"]=>"normal", ["combination", "combination", "combination", "combination", "combination"]=>"combination", ["combination", "combination", "combination", "combination", "sensitive"]=>"combination sensitive", ["combination", "combination", "combination", "combination", "normal"]=>"combination", ["combination", "combination", "combination", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "combination", "combination", "normal", "sensitive"]=>"combination sensitive", ["combination", "combination", "combination", "normal", "normal"]=>"combination", ["combination", "combination", "sensitive", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "combination", "normal", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "combination", "normal", "normal", "sensitive"]=>"combination sensitive", ["combination", "combination", "normal", "normal", "normal"]=>"combination", ["combination", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["combination", "normal", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["combination", "normal", "normal", "sensitive", "sensitive"]=>"combination sensitive", ["combination", "normal", "normal", "normal", "sensitive"]=>"combination sensitive", ["combination", "normal", "normal", "normal", "normal"]=>"normal", ["sensitive", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["normal", "sensitive", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["normal", "normal", "sensitive", "sensitive", "sensitive"]=>"sensitive", ["normal", "normal", "normal", "sensitive", "sensitive"]=>"sensitive", ["normal", "normal", "normal", "normal", "sensitive"]=>"normal", ["normal", "normal", "normal", "normal", "normal"]=>"normal"}

      unless classes[types].nil?
        diagnosis = Diagnosis.find_by(sub_category: classes[types], category: "skin type quiz")
        simple_quiz_response = SimpleQuizResponse.new(:patient => user, :diagnosis => diagnosis, :responses => options[:responses], :simple_quiz => (SimpleQuiz.find_by :content_type => "skin type quiz"))
        unless simple_quiz_response.save
          session[:error_msgs]["SimpleQuizResponse save failed"] = simple_quiz_response.errors.full_messages.unshift(simple_quiz_response.attributes.to_s)
        end
      else
        session[:error_msgs]["Skin type not found: "] = [types.to_s]
      end

    end

    def check_for_errors
      if session[:error_msgs].present?
        AdminNotifierMailer.send_developer_error_email("Remedico: SelfieForm errors", session[:error_msgs].to_json).deliver_later
        session[:error_msgs] = nil
      end
    end

end
