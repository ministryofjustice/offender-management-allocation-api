require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module OffenderManagementAllocationApi
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true
    config.sentry_dsn = nil
    # config.sentry_dsn = ENV['SENTRY_DSN']
  end
end
