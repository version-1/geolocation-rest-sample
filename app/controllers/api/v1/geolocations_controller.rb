module Api
  module V1
    class GeolocationsController < ActionController::API
      def index
        render json: { api: 'OK' }
      end

      def create
        render json: { api: 'OK' }
      end

      def show
        render json: { api: 'OK' }
      end

      def destroy
        render json: { api: 'OK' }
      end
    end
  end
end
