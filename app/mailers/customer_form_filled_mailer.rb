class CustomerFormFilledMailer < ApplicationMailer

  # day 0
  def send_customer_txn_CTA_testimonials_mail consultation
    @consultation = consultation
    @skin_hair = (['Hairfall or Hair Thinning', 'Dandruff'].include? @consultation.category) ? 'hair' : 'skin'
    subject = "You’re one click away from amazing " + @skin_hair
    @payment_link = "https://remedicohealth.com/consult/payment/instant_payment?p=" + encrypt(@consultation) + "&utm_source=form_filled&utm_medium=email&utm_campaign=ff_txn_CTA_testimonials_d0_v1"
    headers['X-SMTPAPI'] = { category: ["form_filled", "ff_txn_CTA_testimonials_d0_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => subject )
  end

  # day 0
  def send_customer_txn_locked_plan_testimonials_mail consultation
    @consultation = consultation
    @skin_hair = (['Hairfall or Hair Thinning', 'Dandruff'].include? @consultation.category) ? 'hair' : 'skin'
    subject = "You’re one click away from amazing " + @skin_hair
    @payment_link = "https://remedicohealth.com/consult/payment/instant_payment?p=" + encrypt(@consultation) + "&utm_source=form_filled&utm_medium=email&utm_campaign=ff_txn_locked_plan_testimonials_d0_v1"
    headers['X-SMTPAPI'] = { category: ["form_filled", "ff_txn_locked_plan_testimonials_d0_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => subject )
  end

  # day 3
  def send_customer_discount_locked_plan_satisfaction_mail consultation
    @consultation = consultation
    @skin_hair = (['Hairfall or Hair Thinning', 'Dandruff'].include? @consultation.category) ? 'hair' : 'skin'
    @payment_link = "https://remedicohealth.com/consult/patients/coupon_login?promo=CMAIL50&utm_source=form_filled&utm_medium=email&utm_campaign=ff_discount_locked_plan_satisfaction_d3_v1&url=payment&p=" + encrypt(@consultation)
    headers['X-SMTPAPI'] = { category: ["form_filled", "ff_discount_locked_plan_satisfaction_d3_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => "Here’s a gift from us" )
  end
  
  # day 7
  def send_customer_benefits_treatment_plan_mail consultation
    @consultation = consultation
    @payment_link = "https://remedicohealth.com/consult/patients/coupon_login?promo=CMAIL50&utm_source=form_filled&utm_medium=email&utm_campaign=ff_benefits_treatment_plan_d7_v1&url=payment&p=" + encrypt(@consultation)
    headers['X-SMTPAPI'] = { category: ["form_filled", "ff_benefits_treatment_plan_d7_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => "What you’ll get in your treatment plan" )
  end

  # day 7
  def send_customer_testimonials_mail consultation
    @consultation = consultation
    @payment_link = "https://remedicohealth.com/consult/patients/coupon_login?promo=CMAIL50&utm_source=form_filled&utm_medium=email&utm_campaign=ff_testimonials_d7_v1&url=payment&p=" + encrypt(@consultation)
    headers['X-SMTPAPI'] = { category: ["form_filled", "ff_testimonials_d7_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => "Hear from our customers" )
  end

end
