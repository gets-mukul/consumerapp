class ConsultationController < ApplicationController
  include PatientsHelper
  before_action :check_current_user

  def index
    @patient = Patient.new
    @condition = session[:condition]
  end

  def consultation_form
    if params[:condition]
      @condition = params[:condition]
      session[:condition] = @condition = params[:condition]
    else
      redirect_to :new_patient_path
    end
    typeform = {
      "Acne" => "https://remedica.typeform.com/to/Eb3Oby",
      "Hairfall or Hair Thinning" => "https://remedica.typeform.com/to/WqEAeB",
      "Pigmentation & Dark Circles" => "https://remedica.typeform.com/to/RgTtE0",
      "Pigmentation and Dark Circles" => "https://remedica.typeform.com/to/RgTtE0",
      "Dandruff" => "https://remedica.typeform.com/to/WqEAeB",
      "Eczema, Psoriasis & Rash" => "https://remedica.typeform.com/to/VuHuwt",
      "Eczema, Psoriasis and Rash" => "https://remedica.typeform.com/to/VuHuwt",
      "Stretch Marks" => "https://remedica.typeform.com/to/lSTMhj",
      "Skin Growth (Moles, Warts)" => "https://remedica.typeform.com/to/qs6Oc7"
    }

    @condition_form = typeform[@condition] << "?mobile=#{current_user.mobile}&name=#{current_user.name}"
    session[:typeform_uid] = typeform[@condition].scan(/\/([\w]*)\?/)[0][0]
  end

  def welcome
  end
end
