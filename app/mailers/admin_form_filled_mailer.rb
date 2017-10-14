class AdminFormFilledMailer < ApplicationMailer

  def send_form_fills_mail()
  	@start_date = (Time.now - 24.hours).strftime("%d/%m/%Y");
  	@end_date = Time.now.strftime("%d/%m/%Y");
    subject = "Remedico: form fills during " + @start_date + " - " + @end_date
    @consultations = Consultation.where(created_at: 24.hours.ago..Time.now, user_status: 'form filled').joins('LEFT JOIN patients on consultations.patient_id=patients.id').joins('LEFT OUTER JOIN coupons on consultations.coupon_id=coupons.id').select('distinct on (consultations.id) consultations.id, patients.id as pid, patients.name, patients.mobile, consultations.user_status, coupons.coupon_code as coupon, consultations.created_at')
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
     # mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
    :subject => subject )
  end

end
