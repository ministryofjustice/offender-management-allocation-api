require 'swagger_helper'

describe 'POST /allocation', type: :request do
  path '/allocation' do
    post 'Creates a new allocation' do
      tags 'Allocation'
      produces 'application/json'
      security [Bearer: '']

      after do |example|
        # Generate an example for the swagger document if there is a response from
        # the server that can be parsed as json.
        if response.body.present?
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
      end

      response '200', 'Generates an error with missing data' do
        let(:Authorization) { "Bearer #{generate_jwt_token}" }
        let(:allocation) { { staff_id: '1' } }

        run_test! do |response|
          json = JSON.parse(response.body)

          expect(json['status']).to eq('error')
          expect(json['errorMessage']).to include('Validation failed:')
          expect(json['errorMessage']).to include("Offender no can't be blank")
          expect(json['errorMessage']).to include("Offender can't be blank")
          expect(json['errorMessage']).to include("Prison can't be blank")
          expect(json['errorMessage']).to include("Allocated at tier can't be blank")
          expect(json['errorMessage']).to include("Created by can't be blank")
        end
      end

      response '200', 'Creates a new allocation, inactivating any previous allocations for the offender' do
        consumes 'application/json'
        parameter name: :allocation, in: :body, schema: {
          type: :object,
          properties: {
            staff_id: { type: :string },
            offender_no: { type: :string },
            offender_id: { type: :string },
            allocated_at_tier: { type: :string },
            prison: { type: :string },
            created_by: { type: :string },
            override_reason: { type: :string },
            note: { type: :string },
            email: { type: :string }
          },
          required: %w[staff_id offender_no offender_id prison note]
        }
        schema type: :object,
               properties: {
                 status: { type: :string },
                 errorMessage: { type: :string }
               }

        let(:Authorization) { "Bearer #{generate_jwt_token}" }
        let(:allocation) {
          {
            staff_id: '1',
            offender_no: '1',
            offender_id: 'A1A',
            prison: 'LEI',
            created_by: 'Fred',
            allocated_at_tier: 'A',
            note: 'A comment',
            override_reason: ' ',
            email: 'test@example.com'
          }
        }
        run_test! do |response|
          json = JSON.parse(response.body)

          expect(json['status']).to eq('ok')
          expect(json['errorMessage']).to eq('')

          expect(Allocation.count).to eq(1)
          expect(Allocation.first.offender_id).to eq('A1A')
        end
      end

      response '401', 'Must be authenticated to create an allocation' do
        let(:Authorization) { '' }
        let(:allocation) { { staff_id: '1' } }

        run_test!
      end
    end
  end
end
