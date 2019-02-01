require 'swagger_helper'

describe 'GET /poms', type: :request do
  before do
    Staff.create!(staff_id: '1', working_pattern: '0.5', status: 'active')
    Staff.create(staff_id: '2', working_pattern: '0.5', status: 'active')
    Staff.create(staff_id: '3', working_pattern: '0.5', status: 'active')
  end

  path '/poms/1,2,3' do
    get 'Prisoner Offender Managers by multiple ID' do
      tags 'Allocation'
      produces 'application/json'
      security [Bearer: '']

      response '200', 'Gets a list of Prisoner Offender Managers' do
        let(:Authorization) { "Bearer #{generate_jwt_token}" }

        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json['poms'].length).to eq(3)
        end
      end
    end
  end
end
