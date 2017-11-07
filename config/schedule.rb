admin_form_fill_mails_job:
  cron: "0 18 * * *" # execute at every day 6 p.m. 
  class: "DeliverAdminFormFillsMailWorker"
  queue: default

update_google_sheets_job:
  cron: "0 */3 * * *" # execute at every 3 hours 
  class: "UpdateSheetsWorker"
  queue: default
