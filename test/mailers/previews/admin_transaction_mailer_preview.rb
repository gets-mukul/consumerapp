# Preview all emails at http://localhost:3000/rails/mailers/admin_transaction_mailer
class AdminTransactionMailerPreview < ActionMailer::Preview

  def send_pending_transaction_mail
    AdminTransactionMailer.send_pending_transaction_mail(Payment.find(1209))
  end
  
  def send_user_payment_mail
    AdminTransactionMailer.send_user_payment_mail(Patient.find(4287), Payment.find(1208), '')

    # c = Consultation.find(101)
    # @user = c.patient
    # @payment = Payment.where(:consultation => c).first
    # AdminTransactionMailer.send_user_payment_mail(@user, @payment, '')
  end

  def send_user_reverse_payment_mail
    AdminTransactionMailer.send_user_reverse_payment_mail(MyConsultation.find(16))
  end

  def send_free_consultation_notifier_mail
    @consultation = Consultation.find 4744
    @coupon = @consultation.coupon
    AdminTransactionMailer.send_free_consultation_notifier_mail(@consultation)
  end
  
  def error_email
    AdminTransactionMailer.error_email('There was a problem with your transaction')
  end

end
