module Api
  module V1
    class GeolocationsController < ApplicationController
      DEFAULT_INCLUDE_OPTIONS = %w[user provider].freeze

      def index
        render json: current_user.geolocations, include: DEFAULT_INCLUDE_OPTIONS
      end

      def create
        Geolocation.add!(current_user, create_params[:ip_or_hostname])

        render json: { data: nil }, status: :created
      end

      def show
        render json: geolocation, include: DEFAULT_INCLUDE_OPTIONS
      end

      def destroy
        if geolocation.destroy
          render json: geolocation, include: DEFAULT_INCLUDE_OPTIONS
        else
          render json: ErrorSerialzer.new(geolocation), status: :internal_server_error
        end
      end

      private

      def create_params
        params.require(:geolocation).permit(:ip_or_hostname)
      end

      def geolocation
        @geolocation ||= current_user.geolocations.find_by!(uuid: params[:id])
      end
    end
  end
end
