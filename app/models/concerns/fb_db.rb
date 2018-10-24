module FbDb
  extend ActiveSupport::Concern

  def self.raw_query(query, params)
    ActiveRecord::Base.connection.exec_query(
      ActiveRecord::Base.send(:sanitize_sql_array, [query] + params)
    )
  end

  def self.with_db(another_db_config)
    original_connection = ActiveRecord::Base.remove_connection
    ActiveRecord::Base.establish_connection(another_db_config)
    yield
  ensure
    ActiveRecord::Base.establish_connection(original_connection)
  end
end
