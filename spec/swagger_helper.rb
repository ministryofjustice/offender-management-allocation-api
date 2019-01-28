require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'

  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'Offender Management Allocation API',
        version: 'v1'
      },
      paths: {},
      securityDefinitions: {
        Bearer: {
          description: "...",
          type: :apiKey,
          name: 'Authorization',
          in: :header
        }
      }
    }
  }
end
