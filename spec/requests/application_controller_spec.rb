require 'rails_helper'
# require 'byebug'

describe ApplicationController do
  describe 'JWT validation' do
    describe 'without a JWT token' do
      it 'returns HTTP status 401' do
        get('/status')

        expect(response.status).to be(401)
        expect(response.headers['WWW-Authenticate']).to eq('Bearer scope=""')
      end
    end

    describe 'with a valid JWT token' do
      it 'returns HTTP status 200' do
        get('/status', headers: generate_jwt_token)

        expect(response.status).to be(200)
        expect(response.headers['WWW-Authenticate']).to eq('Bearer scope="read"')
      end
    end

    describe 'with an invalid JWT token' do
      describe 'that is expired' do
        it 'returns HTTP status 401' do
          expired_token = generate_jwt_token(exp: Time.new(2018).to_i)

          get('/status', headers: expired_token)

          expect(response.status).to be(401)
          expect(response.headers['WWW-Authenticate']).to eq('Bearer scope=""')
        end
      end

      describe 'that does not have correct scope' do
        it 'returns HTTP status 401' do
          token_without_scope = generate_jwt_token(scope: [])

          get('/status', headers: token_without_scope)

          expect(response.status).to be(401)
          expect(response.headers['WWW-Authenticate']).to eq('Bearer scope=""')
        end
      end

      describe 'that has been encoded with an incorrect or altered private key' do
        it 'returns HTTP status 401' do
          Rails.configuration.nomis_oauth_public_key = OpenSSL::PKey::RSA.generate(2048).public_key
          payload = {}
          incorrect_token = OpenSSL::PKey::RSA.generate(2048)
          token = JWT.encode payload, incorrect_token, 'RS256'
          auth_header = { 'Authorization': token.to_s }

          get('/status', headers: auth_header)

          expect(response.status).to be(401)
          expect(response.headers['WWW-Authenticate']).to eq('Bearer scope=""')
        end
      end
    end
  end
end
