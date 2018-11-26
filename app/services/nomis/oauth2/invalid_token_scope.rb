# :nocov:
module Nomis
  module Oauth2
    class InvalidTokenScope < StandardError
      def initialize(msg = 'Invalid token scope')
        super
      end
    end
  end
end
# :nocov:
