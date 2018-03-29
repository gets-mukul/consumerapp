class CustomerPaidMailer < ApplicationMailer

  # day 0
  def send_customer_txn_mail consultation
    @consultation = consultation
    @skin_hair = (['Hairfall or Hair Thinning', 'Dandruff'].include? @consultation.category) ? 'hair' : 'skin'
    headers['X-SMTPAPI'] = { category: ["paid", "pd_txn_d0_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => "Your payment is successful!" )
  end

  # day 7
  def send_customer_how_is_it_going_mail consultation
    @consultation = consultation
    headers['X-SMTPAPI'] = { category: ["paid", "pd_how_is_it_going_mail_d7_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => "How’s it going" )
  end

  # day 10
  def send_customer_cross_sell_mail consultation
    @consultation = consultation
    @skin_hair = (['Hairfall or Hair Thinning', 'Dandruff'].include? @consultation.category) ? 'hair' : 'skin'
    @new_consultation_link = "https://remedicohealth.com/consult/patients/coupon_login?promo=CMAIL100&utm_source=paid&utm_medium=email&utm_campaign=pd_cross_sell_mail_d10_v1&condition=General%20Skin%20Care&name="+@consultation.patient.name+"&mobile="+@consultation.patient.mobile
    headers['X-SMTPAPI'] = { category: ["paid", "pd_cross_sell_mail_d10_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => "Need any other help?" )
  end

  # day 14
  def send_customer_referral_mail consultation
    @consultation = consultation
    @referral_code = encrypt(@consultation.patient)
    headers['X-SMTPAPI'] = { category: ["paid", "pd_referral_mail_d14_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => "Share the love" )
  end

  # day 18
  def send_customer_follow_up_mail consultation
    @consultation = consultation
    headers['X-SMTPAPI'] = { category: ["paid", "pd_follow_up_mail_d18_v1"] }.to_json

    mail( :to => @consultation.patient.email, :subject => "Is it time for your follow up?" )
  end

end
