require 'rails_helper'

RSpec.describe 'Status requests' do
  describe 'GET /status' do
    it 'returns a status message' do
      get('/status')
      json = JSON.parse(response.body)

      expect(json['status']).to eq('ok')
    end

    it 'returns the postgres client version' do
      get('/status')
      json = JSON.parse(response.body)

      expect(json['postgresVersion']).to match(/PostgreSQL/)
    end
  end
end
