module ExternalConnectionHelper
  def with_external_db
    original_connection = ActiveRecord::Base.remove_connection
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['external_production'])
    yield
  ensure
    ActiveRecord::Base.establish_connection(original_connection)
  end
end
