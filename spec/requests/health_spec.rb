require 'swagger_helper'

describe 'GET /health', type: :request do
  path '/health' do
    get 'Gets system health' do
      tags 'System'
      produces 'text/plain'

      response '200', 'Successfully returned the system health' do
        run_test! do |response|
          expect(response.body).to include('Everything is fine.')
        end
      end
    end
  end
end
