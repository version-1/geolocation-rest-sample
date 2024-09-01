module Api
  module V1
    class GeolocationsController < ApplicationController
      def index
        render json: Geolocation.all
      end

      def create
        Geolocation.add!(create_params[:ip_or_hostname])

        render json: { data: nil }, status: :created
      rescue => e
        render json: ErrorSerializer.internal_server_error(e), status: :internal_server_error
      end

      def show
        render json: geolocation
      end

      def destroy
        if geolocation.destroy
          render json: geolocation
        else
          render json: ErrorSerialzer.new(geolocation), status: :internal_server_error
        end
      end

      private

      def create_params
        params.require(:geolocation).permit(:ip_or_hostname)
      end

      def geolocation
        @geolocation ||= Geolocation.find_by!(uuid: params[:id])
      end
    end
  end
end
