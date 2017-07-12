class ErrorEmailer < ApplicationMailer

  def error_email msg
    # @user = user
    # @payment = payment
    @msg = msg
    p @msg
    mail( :to => "rohitkhatana.khatana@gmail.com", :subject => "Remedica: Payment failure." )
  end
end
