require 'rails_helper'

describe 'GET /status', type: :request do
  it 'returns the status of the database' do
    get('/status', headers: generate_jwt_token)
    json = JSON.parse(response.body)

    expect(json['status']).to eq('ok')
    expect(json['postgresVersion']).to match(/PostgreSQL/)
  end
end
