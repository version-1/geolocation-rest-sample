module Api
  module V1
    class HealthCheckController < ActionController::API
      def show
        render json: { message: 'ok' }
      end
    end
  end
end
