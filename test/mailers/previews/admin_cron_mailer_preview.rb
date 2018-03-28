# Preview all emails at http://localhost:3000/rails/mailers/admin_cron_mailer
class AdminCronMailerPreview < ActionMailer::Preview
  def send_form_fills_mail
    start_date = (Time.now - 24.hours).strftime("%d/%m/%Y")
    end_date = Time.now.strftime("%d/%m/%Y")
    AdminCronMailer.send_form_fills_mail(start_date, end_date)
  end
end
