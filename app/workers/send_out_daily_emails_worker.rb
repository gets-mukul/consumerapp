class SendOutDailyEmailsWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :low, :retry => 3

  def perform()
    puts "SIDEKIQ WORKER RUNNING"
    puts "DELIVER MAILS"
    
    # paid mails
    
    # day 7
    consultations = Consultation.created_between(-7, -7).where(:user_status => 'paid')
    consultations.each do |consultation|
      CustomerPaidMailer.send_customer_how_is_it_going_mail(consultation).deliver_later
    end
    
    # day 10
    consultations = Consultation.created_between(-10, -10).where(:user_status => 'paid')
    consultations.each do |consultation|
      CustomerPaidMailer.send_customer_cross_sell_mail(consultation).deliver_later
    end
    
    # day 14
    consultations = Consultation.created_between(-14, -14).where(:user_status => 'paid')
    consultations.each do |consultation|
      CustomerPaidMailer.send_customer_referral_mail(consultation).deliver_later
    end
    
    # day 18
    consultations = Consultation.created_between(-18, -18).where(:user_status => 'paid')
    consultations.each do |consultation|
      CustomerPaidMailer.send_customer_follow_up_mail(consultation).deliver_later
    end
    
    # form filled mails
    
    # day 3
    consultations = Consultation.created_between(-7, -7).where("user_status like 'form filled%' or user_status like 'payment failed%' or user_status like 'processing%'")
    consultations.each do |consultation|
      CustomerFormFilledMailer.send_customer_discount_locked_plan_satisfaction_mail(consultation).deliver_later
    end
    
    # day 7
    consultations = Consultation.created_between(-3, -3).where("user_status like 'form filled%' or user_status like 'payment failed%' or user_status like 'processing%'").in_groups(2)
    consultations[0].each do |consultation|
      CustomerFormFilledMailer.send_customer_benefits_treatment_plan_mail(consultation).deliver_later
    end
    consultations[1].each do |consultation|
      CustomerFormFilledMailer.send_customer_testimonials_mail(consultation).deliver_later
    end

  end
end
