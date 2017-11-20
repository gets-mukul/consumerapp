admin_form_fill_mails_job:
  cron: "0 18 * * *" # execute at every day 6 p.m. 
  class: "DeliverAdminFormFillsMailWorker"
  queue: default

update_google_sheets_job:
  cron: "0 3 */1 * *" # execute every day at 03:00
  class: "UpdateSheetsWorker"
  queue: default
