# Preview all emails at http://localhost:3000/rails/mailers/customer_form_filled_mailer
class CustomerFormFilledMailerPreview < ActionMailer::Preview

  def day_00_send_customer_txn_CTA_testimonials_mail
    CustomerFormFilledMailer.send_customer_txn_CTA_testimonials_mail Consultation.find(4746)
  end

  def day_00_send_customer_txn_locked_plan_testimonials_mail
    CustomerFormFilledMailer.send_customer_txn_locked_plan_testimonials_mail Consultation.find(4746)
  end

  def day_03_send_customer_discount_locked_plan_satisfaction_mail
    CustomerFormFilledMailer.send_customer_discount_locked_plan_satisfaction_mail Consultation.find(4746)
  end

  def day_07_send_customer_benefits_treatment_plan_mail
    CustomerFormFilledMailer.send_customer_benefits_treatment_plan_mail Consultation.find(4746)
  end
  
  def day_07_send_customer_benefits_treatment_plan_mail_250_amount
    CustomerFormFilledMailer.send_customer_benefits_treatment_plan_mail Consultation.find(4719)
  end

  def day_07_send_customer_testimonials_mail
    CustomerFormFilledMailer.send_customer_testimonials_mail Consultation.find(4746)
  end

end
