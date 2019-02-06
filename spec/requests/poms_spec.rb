require 'swagger_helper'

describe 'GET /poms', type: :request do
  let(:nomis_offender_id) { 'AB1234BC' }
  let(:nomis_booking_id) { 1_153_753 }
  let(:tier) { 'B' }
  let(:author) { 'Frank' }

  before do
    staff_one = PrisonOffenderManager.create!(nomis_staff_id: 1, working_pattern: '0.5', status: 'active')
    PrisonOffenderManager.create(nomis_staff_id: 1, working_pattern: '0.5', status: 'active')
    PrisonOffenderManager.create(nomis_staff_id: 3, working_pattern: '0.5', status: 'active')
    staff_one.allocations.create!(
      nomis_offender_id: nomis_offender_id,
      nomis_booking_id: nomis_booking_id,
      allocated_at_tier: tier,
      prison: 'LEI',
      created_by: author,
      nomis_staff_id: 1,
      active: true
    )
  end

  path '/poms/id=1&id=2&id=3' do
    get 'Prisoner Offender Managers by multiple ID' do
      tags 'Allocation'
      produces 'application/json'
      security [Bearer: '']

      response '200', 'Gets a list of Prisoner Offender Managers' do
        let(:Authorization) { "Bearer #{generate_jwt_token}" }

        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json['data'].length).to eq(3)
          expect(json['data'].first['allocations'].length).to eq(1)
          expect(json['data'].first['allocations'].first).to include(
            'id' => 1,
            'nomis_booking_id' => nomis_booking_id,
            'nomis_offender_id' => nomis_offender_id,
            'prison' => 'LEI',
            'allocated_at_tier' => tier,
            'reason' => nil,
            'note' => nil,
            'created_by' => author,
            'active' => true,
            'nomis_staff_id' => 1
          )
        end
      end
    end
  end
end
