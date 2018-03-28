# Preview all emails at http://localhost:3000/rails/mailers/customer_paid_mailer
class CustomerPaidMailerPreview < ActionMailer::Preview

  def day_00_send_customer_txn_mail_skin
    CustomerPaidMailer.send_customer_txn_mail Consultation.find(4732)
  end

  def day_00_send_customer_txn_mail_hair
    CustomerPaidMailer.send_customer_txn_mail Consultation.find(4733)
  end

  def day_07_send_customer_how_is_it_going_mail
    CustomerPaidMailer.send_customer_how_is_it_going_mail Consultation.find(4732)
  end

  def day_10_send_customer_cross_sell_mail
    CustomerPaidMailer.send_customer_cross_sell_mail Consultation.find(4732)
  end

  def day_14_send_customer_referral_mail
    CustomerPaidMailer.send_customer_referral_mail Consultation.find(4732)
  end

  def day_18_send_customer_follow_up_mail
    CustomerPaidMailer.send_customer_follow_up_mail Consultation.find(4732)
  end

end
