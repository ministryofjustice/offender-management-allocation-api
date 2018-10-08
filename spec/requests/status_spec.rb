require 'rails_helper'

RSpec.describe 'Status requests' do
  describe 'GET /status' do
    it 'returns a status message' do
      get('/status')
      json = JSON.parse(response.body)

      expect(json['status']).to eq('ok')
    end

    it 'returns the postgres client version' do
      postgres_version = 'PostgreSQL 10.3 on x86_64-apple-darwin14.5.0, compiled by Apple LLVM version 7.0.0 (clang-700.1.76), 64-bit'

      get('/status')
      json = JSON.parse(response.body)

      expect(json['postgresVersion']).to eq(postgres_version)
    end
  end
end
