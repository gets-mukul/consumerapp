class UserPaymentNotifierMailer < ApplicationMailer

  def send_user_payment_mail(user, payment)
    @user = user
    @payment = payment
    # mail( :to => [@user.email, "jesse.dhara@gmail.com"],
    mail( :to => @user.email,
    :subject => "Remedico: Payment notice." )
  end

  def send_user_form_filled_mail(consultation)
    @consultation = consultation
    @payment_link = ""
    if @consultation.amount == 350
      @payment_link = "https://imjo.in/rrn3Ct"
    elsif @consultation.amount == 250
      @payment_link = "https://imjo.in/mx27qE"
    elsif @consultation.amount == 200
      @payment_link = "https://imjo.in/RnnpHx"
    else
      @payment_link = "remedicohealth.com"

    # mail( :to => [@consultation.patient.email, "jesse.dhara@gmail.com"],
    mail( :to => @consultation.patient.email,
    :subject => "Remedico: Payment notice." )
  end

end
