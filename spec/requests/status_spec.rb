require 'swagger_helper'

describe 'GET /status', type: :request do
  path '/status' do
    get 'Gets database status' do
      tags 'System'
      produces 'application/json'
      security [Bearer: {}]

      response '200', 'Successfully returned the database status' do
        examples 'application/json' => {
          'status': 'ok',
          'postgresVersion': 'PostgresSQL 10.0'
        }
        schema type: :object,
               properties: {
                 status: { type: :string },
                 postgresVersion: { type: :string }
               }

        let(:Authorization) { "Bearer #{generate_jwt_token}" }

        run_test! do |response|
          json = JSON.parse(response.body)

          expect(json['status']).to eq('ok')
          expect(json['postgresVersion']).to match(/PostgreSQL/)
        end
      end

      response '401', 'Was not authenticated to return the database status' do
        let(:Authorization) { '' }
        run_test!
      end
    end
  end
end
