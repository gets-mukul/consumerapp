class UpdateSheetsWorker
	require 'update_sheets'
	include Sidekiq::Worker

	def perform()
		puts "SIDEKIQ WORKER RUNNING"
		puts "UPDATE SHEETS"
		update_sheet
	end

end