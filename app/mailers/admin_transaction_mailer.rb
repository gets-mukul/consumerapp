class AdminTransactionMailer < ApplicationMailer

  def send_pending_transaction_mail payment
    @payment = payment
    @patient = payment.patient

    subject = "Remedico: transaction pending"
    # mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse@remedicohealth.com"],
    # mail( :to => "jesse.dhara@gmail.com",
    :subject => subject )
  end

  def send_user_payment_mail(user, payment, doctor)
    @user = user
    @payment = payment
    @doctor = doctor
    @selfie = SelfieForm.where(:patient => @user).first
    @simple_quiz_response = SimpleQuizResponse.find_by(:patient => @user)
    @patient_source = PatientSource.where(:patient => @user).order(:created_at).pluck(:created_at, :local_referrer, :utm_campaign)

    # mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "incaishwarya@gmail.com"],

    :subject => "Remedico: User payment notice" )
  end

  def send_user_reverse_payment_mail my_consultation
    @my_consultation = my_consultation
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, 'jesse@remedicohealth.com', 'incaishwarya@gmail.com'],
    :subject => "Remedico: User payment notice for reverse payment flow" )
  end

  def send_free_consultation_notifier_mail consultation
    @consultation = consultation
    @coupon = @consultation.coupon
    # mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "incaishwarya@gmail.com"],
    :subject => "Remedico: Free consultation notice." )
  end

  def error_email msg
    @msg = msg
    mail( :to => ["bh.ranjit@gmail.com"], :subject => "Remedico: Payment failure." )
  end

  def send_user_form_filled_notifier_mail(consultation)
    @consultation = consultation
    @questionnaire_response = @consultation.questionnaire_response
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, 'jesse@remedicohealth.com'],
    :subject => "Remedico: New response from #{consultation.patient}" )
  end

end
