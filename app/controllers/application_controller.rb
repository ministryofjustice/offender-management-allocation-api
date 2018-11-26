require 'jwt'

class ApplicationController < ActionController::API
  def authenticate
    head 401 unless token && token_valid?
  end

private

  # :nocov:

  def token
    request.headers[:authorization]&.split(' ')&.last
  end

  def token_valid?
    decoded_token = JWT.decode(
      token,
      nomis_oauth_public_key,
      true,
      algorithm: 'RS256'
    )

    correct_scope?(decoded_token)

    decoded_token
  rescue JWT::ExpiredSignature, JWT::DecodeError, Nomis::Oauth2::InvalidTokenScope => e
    Raven.capture_exception(e)
    head :unauthorized
  end

  def nomis_oauth_public_key
    OpenSSL::PKey::RSA.new(Rails.configuration.nomis_oauth_public_key)
  end

  def correct_scope?(decoded_token)
    scope = decoded_token.first['scope']

    raise Nomis::Oauth2::InvalidTokenScope if invalid?(scope)
  end

  def invalid?(scope)
    scope.empty? || !scope.include?('read')
  end

  # :nocov:
end

