class DeliverAdminFormFillsMailWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "RUNNING CRON JOB - DELIVEREING ADMIN FORM FILLED MAILS"
    AdminFormFilledMailer.send_form_fills_mail().deliver_later()
  end
end
