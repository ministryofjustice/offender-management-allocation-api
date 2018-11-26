module Request
  module AuthHelpers
    def generate_jwt_token(options = {})
      payload = {
        'internal_user': false,
        'scope': %w[read write],
        'exp': Time.new.to_i + 4 * 3600,
        'client_id': 'offender-manager-allocation-manager'
      }.merge(options)

      rsa_private = OpenSSL::PKey::RSA.generate 2048
      rsa_public = rsa_private.public_key

      Rails.configuration.nomis_oauth_public_key = rsa_public

      token = JWT.encode payload, rsa_private, 'RS256'
      {
        'Authorization': "Bearer #{token.to_s}"
      }
    end
  end
end
