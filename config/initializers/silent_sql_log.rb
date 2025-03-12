# https://github.com/duleorlovic/rails_utils_and_const/blob/main/config/initializers/silent_sql_log.rb
ActiveSupport::Notifications.unsubscribe("sql.active_record") if ENV["SILENT_SQL_LOG"]
