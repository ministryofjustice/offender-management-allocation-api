require 'jwt'

module Authorisable
  extend ActiveSupport::Concern

  def authenticate
    if token && token_valid?
      response.headers['WWW-Authenticate'] = 'Bearer scope="read"'
    else
      send_unauthorised_response
    end
  end

private

  def send_unauthorised_response
    head(
      :unauthorized,
      'WWW-Authenticate' => 'Bearer scope=""'
    )
  end

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
  rescue JWT::ExpiredSignature, JWT::DecodeError, Nomis::Oauth2::InvalidTokenScope => e
    Raven.capture_exception(e)
  end

  def nomis_oauth_public_key
    OpenSSL::PKey::RSA.new(Rails.configuration.nomis_oauth_public_key)
  end

  def correct_scope?(decoded_token)
    scope = decoded_token.first['scope']

    if invalid?(scope)
      raise Nomis::Oauth2::InvalidTokenScope
    else
      true
    end
  end

  def invalid?(scope)
    scope.empty? || !scope.include?('read')
  end
end
