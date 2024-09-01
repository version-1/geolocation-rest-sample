module Api
  module V1
    class HealthCheckController < ApplicationController
      def show
        render json: { message: 'ok' }
      end
    end
  end
end
