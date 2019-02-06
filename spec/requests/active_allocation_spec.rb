require 'swagger_helper'

describe 'POST /allocation', type: :request do
  before do
    staff_one = PrisonOffenderManager.create!(nomis_staff_id: 1, working_pattern: 0.5, status: 'active')
    staff_two = PrisonOffenderManager.create(nomis_staff_id: 2, working_pattern: 0.5, status: 'active')
    staff_one.allocations.create!(
      nomis_offender_id: 'AB1234BC',
      nomis_booking_id: 12_345,
      allocated_at_tier: 'B',
      prison: 'LEI',
      created_by: 'Frank',
      nomis_staff_id: 1,
      active: true
    )
    staff_two.allocations.create!(
      nomis_offender_id: 'AB1234DD',
      nomis_booking_id: 12_346,
      allocated_at_tier: 'C',
      prison: 'LEI',
      created_by: 'Frank',
      nomis_staff_id: 2,
      active: true
    )
    staff_two.allocations.create!(
      nomis_offender_id: 'AB1234BC',
      nomis_booking_id: 12_347,
      allocated_at_tier: 'B',
      prison: 'LEI',
      created_by: 'Frank',
      nomis_staff_id: 1,
      active: false
    )
  end

  path '/allocation/active' do
    post 'Obtains active allocation for provided offender id(s)' do
      tags 'Allocation'
      produces 'application/json'
      consumes 'application/json'
      security [Bearer: '']
      parameter name: :ids, in: :body, schema: {
        type: :array,
        items: { type: :string, required: true }
      }

      after do |example|
        # Generate an example for the swagger document if there is a response from
        # the server that can be parsed as json.
        if response.body.present?
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
      end

      response '200', 'Returns active allocations for provided offender ids' do
        let(:Authorization) { "Bearer #{generate_jwt_token}" }
        let(:ids) { %w[AB1234BC AB1234DD] }

        run_test! do |response|
          json = JSON.parse(response.body)

          expect(json['status']).to eq('ok')
          expect(json['data']['AB1234BC']['nomis_staff_id']).to eq(1)
          expect(json['data']['AB1234DD']['nomis_staff_id']).to eq(2)
        end
      end

      response '401', 'Must be authenticated to create an allocation' do
        let(:Authorization) { '' }
        let(:ids) { %w[AB1234BC AB1234DD] }
        run_test!
      end
    end
  end
end
