class DeliverAdminFormFillsMailWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :low, :retry => 2

  def perform(*args)
    puts "RUNNING CRON JOB - DELIVEREING ADMIN FORM FILLED MAILS"
    start_date = (Time.now - 24.hours).strftime("%d/%m/%Y")
    end_date = Time.now.strftime("%d/%m/%Y")
    AdminCronMailer.send_form_fills_mail(start_date, end_date).deliver_later()
  end
end
