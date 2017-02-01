class ConsultationController < ApplicationController
  def index
    @patient = Patient.new
  end

  def consultation_form
    if params[:condition]
      @condition = params[:condition]
    else
      redirect_to :new_patient_path
    end
    typeform = {
      "Acne" => "https://remedica.typeform.com/to/Eb3Oby",
      "Hairfall or Hair Thinning" => "https://remedica.typeform.com/to/WqEAeB",
      "Pigmentation or Coloration" => "https://remedica.typeform.com/to/RgTtE0",
      "Dandruff" => "https://remedica.typeform.com/to/WqEAeB",
      "Eczema, Psoriasis & Rash" => "https://remedica.typeform.com/to/VuHuwt",
      "Stretch Marks" => "https://remedica.typeform.com/to/lSTMhj",
      "Skin Growth (Moles, Warts)" => "https://remedica.typeform.com/to/qs6Oc7"
                }

    @condition_form = typeform[@condition] << "?email=#{current_user.email}&mobile=#{current_user.mobile}&name=#{current_user.name}"
    session[:typeform_uid] = typeform[@condition].scan(/\/([\w]*)\?/)[0][0]
  end

  def welcome
  end
end
