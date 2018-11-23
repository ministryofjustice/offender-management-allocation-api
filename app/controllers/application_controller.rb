require 'jwt'
class ApplicationController < ActionController::API
  def authenticate
    head 401 unless token && token_valid?
  end

private

  def token
    request.headers[:authorization]&.split(' ')&.last
  end

  def token_valid?
    JWT.decode token,
      nomis_oauth_public_key,
      true,
      algorithm: 'RS256'
  rescue JWT::ExpiredSignature, JWT::DecodeError
    head 401
  end

  def nomis_oauth_public_key
    OpenSSL::PKey::RSA.new(Rails.configuration.nomis_oauth_public_key)
  end
end
