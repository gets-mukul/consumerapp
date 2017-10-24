class UpdateSheetsWorker
	require 'update_sheets'
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform()
		puts "SIDEKIQ WORKER RUNNING"
		puts "UPDATE SHEETS"
		update_sheet
	end

end