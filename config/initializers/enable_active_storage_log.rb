# https://github.com/duleorlovic/rails_utils_and_const/blob/main/config/initializers/enable_active_storage_log.rb
ActiveSupport::Notifications.unsubscribe("service_active_storage") unless ENV["ENABLE_ACTIVE_STORAGE_LOG"]
