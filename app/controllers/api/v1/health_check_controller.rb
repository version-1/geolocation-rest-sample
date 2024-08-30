module Api
  module V1
    class HealthCheckController < ActionController::API
      def show
        render json: { api: 'OK' }
      end
    end
  end
end
