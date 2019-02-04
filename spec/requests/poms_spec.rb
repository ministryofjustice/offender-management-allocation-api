require 'swagger_helper'

describe 'GET /poms', type: :request do
  before do
    staff_one = PrisonOffenderManager.create!(nomis_staff_id: '1', working_pattern: '0.5', status: 'active')
    PrisonOffenderManager.create(nomis_staff_id: '2', working_pattern: '0.5', status: 'active')
    PrisonOffenderManager.create(nomis_staff_id: '3', working_pattern: '0.5', status: 'active')
    staff_one.allocations.create!(
      offender_id: 'AB1234BC',
      offender_no: '12345',
      allocated_at_tier: 'B',
      prison: 'LEI',
      created_by: 'Frank',
      nomis_staff_id: '1',
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
          expect(json['poms'].length).to eq(3)
          expect(json['poms'].first['allocations'].length).to eq(1)
          expect(json['poms'].first['allocations'].first).to include(
            "id" => 1,
            "offender_no" => "12345",
            "offender_id" => "AB1234BC",
            "prison" => "LEI",
            "allocated_at_tier" => "B",
            "reason" => nil,
            "note" => nil,
            "created_by" => "Frank",
            "active" => true,
            "nomis_staff_id" => 1
          )
        end
      end
    end
  end
end
