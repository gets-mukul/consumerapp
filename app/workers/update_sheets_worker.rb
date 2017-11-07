class UpdateSheetsWorker
  require 'update_sheets'
  include Sidekiq::Worker
  sidekiq_options :retry => 2

  def perform()
    puts "RUNNING CRON JOB - UPDATE SHEETS"
    update_sheet
  end
end
