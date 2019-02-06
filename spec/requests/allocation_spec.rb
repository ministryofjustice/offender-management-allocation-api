require 'swagger_helper'

describe 'POST /allocation', type: :request do
  before do
    staff_one = PrisonOffenderManager.create!(nomis_staff_id: 1, working_pattern: 0.5, status: 'active')
    PrisonOffenderManager.create!(nomis_staff_id: 2, working_pattern: 0.5, status: 'active')
    PrisonOffenderManager.create!(nomis_staff_id: 3, working_pattern: 0.5, status: 'active')
    staff_one.allocations.create!(
      nomis_offender_id: 'AB1234BC',
      nomis_booking_id: 123_456,
      allocated_at_tier: 'B',
      prison: 'LEI',
      created_by: 'Frank',
      nomis_staff_id: 1,
      active: true
    )
  end

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
        let(:allocation) { { allocation: { prison_offender_manager_id: '1' } } }

        run_test! do |response|
          json = JSON.parse(response.body)

          expect(json['status']).to eq('error')
          expect(json['errorMessage']).to eq('Invalid request')
        end
      end

      response '200', 'Creates a new allocation, deactivating any previous allocations for the offender' do
        consumes 'application/json'
        parameter name: :allocation, in: :body, schema: {
          type: :object,
          properties: {
            nomis_staff_id: { type: :integer },
            nomis_offender_no: { type: :string },
            nomis_booking_id: { type: :integer },
            allocated_at_tier: { type: :string },
            prison: { type: :string },
            created_by: { type: :string },
            override_reason: { type: :string },
            note: { type: :string },
            email: { type: :string }
          },
          required: %w[nomis_staff_id nomis_offender_id nomis_booking_id prison note]
        }
        schema type: :object,
               properties: {
                 status: { type: :string },
                 errorMessage: { type: :string }
               }

        let(:Authorization) { "Bearer #{generate_jwt_token}" }
        let(:nomis_offender_id) { 'G4273GI' }
        let(:allocation) {
          {
            nomis_staff_id: 1,
            nomis_offender_id: nomis_offender_id,
            nomis_booking_id: 1_153_753,
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

          expect(Allocation.count).to eq(2)
          expect(Allocation.where(nomis_offender_id: nomis_offender_id).first).not_to be_nil
          expect(Allocation.where(nomis_offender_id: nomis_offender_id).first.nomis_staff_id).to eq(1)
        end
      end

      response '401', 'Must be authenticated to create an allocation' do
        let(:Authorization) { '' }
        let(:allocation) { { prison_offender_manager_id: '1' } }

        run_test!
      end
    end
  end
end
