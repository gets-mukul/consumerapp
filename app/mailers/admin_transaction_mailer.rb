class AdminTransactionMailer < ApplicationMailer

  def send_pending_transaction_mail(payment)
    @payment = payment
    @patient = payment.patient

    subject = "Remedico: transaction pending"
    # mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse@remedicohealth.com"],
    # mail( :to => "jesse.dhara@gmail.com",
    :subject => subject )
  end

end
