Rails.application.configure do
  config.lograge.base_controller_class = 'ActionController::API'

  stdout_logger = ActiveSupport::Logger.new(STDOUT)
  config.lograge.logger.extend(ActiveSupport::Logger.broadcast(stdout_logger))
end
