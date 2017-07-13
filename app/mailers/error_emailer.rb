class ErrorEmailer < ApplicationMailer

  def error_email msg
    # @user = user
    # @payment = payment
    @msg = msg
    mail( :to => ["bh.ranjit@gmail.com ","rohitkhatana.khatana@gmail.com"], :subject => "Remedica: Payment failure." )
  end
end
