class AdminFormFilledMailer < ApplicationMailer

  def send_form_fills_mail(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    subject = "Remedico: form fills during " + @start_date + " - " + @end_date
    # @consultations = Consultation.where(created_at: 24.hours.ago..Time.now, user_status: 'form filled').joins('LEFT JOIN patients on consultations.patient_id=patients.id').joins('LEFT OUTER JOIN coupons on consultations.coupon_id=coupons.id').select('distinct on (consultations.id) consultations.id, patients.id as pid, patients.name, patients.mobile, consultations.category, coupons.coupon_code as coupon, consultations.created_at')
    # @consultations = Consultation.where(created_at: 24.hours.ago..Time.now, user_status: 'form filled').joins('LEFT JOIN patients on consultations.patient_id=patients.id').joins('LEFT OUTER JOIN coupons on consultations.coupon_id=coupons.id').pluck("distinct on (consultations.id) consultations.id, patients.id, patients.name, patients.mobile, consultations.category, to_char(consultations.created_at, 'DD-MM-YYYY HH24:MI'), coupons.coupon_code")
    @consultations = Consultation.where("user_status LIKE 'form filled' or user_status LIKE 'payment failed%'").where(created_at: 24.hours.ago..Time.now).joins('LEFT JOIN patients on consultations.patient_id=patients.id').joins('LEFT OUTER JOIN coupons on consultations.coupon_id=coupons.id').joins("LEFT OUTER JOIN payments on consultations.id=payments.consultation_id").group("consultations.id, patients.id, coupons.coupon_code").pluck("distinct on (consultations.id) consultations.id, patients.id, patients.name, patients.mobile, consultations.category, to_char(consultations.created_at, 'DD-MM-YYYY HH24:MI'), coupons.coupon_code, array_to_string(Array_agg(payments.mode), ', ', '*')")

    # mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse@remedicohealth.com"],
    # mail( :to => "jesse.dhara@gmail.com",
    :subject => subject )
  end

end
