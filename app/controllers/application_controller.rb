class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  # protect_from_forgery
  # protect_from_forgery prepend: true
  include PatientsHelper
  include ConsultationHelper
end
