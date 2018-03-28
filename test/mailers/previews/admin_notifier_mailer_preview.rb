# Preview all emails at http://localhost:3000/rails/mailers/admin_notifier_mailer
class AdminNotifierMailerPreview < ActionMailer::Preview

  def send_new_user_mail
    AdminNotifierMailer.send_new_user_mail(Patient.find(4287))
  end

  def send_new_user_mail_with_insta
    AdminNotifierMailer.send_new_user_mail_with_insta(Patient.find(4287), 'instaking', 'WEKIJYPN')
  end

end
