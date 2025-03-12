# https://github.com/duleorlovic/rails_utils_and_const/blob/main/config/initializers/enable_action_cable_log.rb
ActionCable.server.config.logger = ActiveSupport::Logger.new(nil) unless ENV["ENABLE_ACTION_CABLE_LOG"]
