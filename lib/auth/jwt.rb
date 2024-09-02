module Auth
  class Jwt
    class << self
      def encode(email)
        payload = {
          sub: email
        }
        JWT.encode(payload, secret || '[jwt secret]', 'HS256')
      end

      def decode(token)
        JWT.decode(token, secret, true, algorithm: 'HS256')
      end

      def secret
        return '[jwt_secret]' unless Rails.env.production?

        ENV.fetch('JWT_SECRET')
      end
    end
  end
end
