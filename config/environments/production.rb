Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.active_storage.service = :local
  config.log_level = :debug
  config.log_tags = [:request_id]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new

  config.lograge.logger = ActiveSupport::Logger.new \
    "#{Rails.root}/log/logstash_#{Rails.env}.json"

  config.nomis_oauth_public_key = ENV.fetch('NOMIS_OAUTH_PUB_KEY')
end
