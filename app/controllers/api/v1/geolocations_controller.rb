module Api
  module V1
    class GeolocationsController < ActionController::API
      # def index
      #   render json: { api: 'OK' }
      # end

      def create
        Geolocation.add!(create_params)

        # FIXME: render jsonapi
        render json: {}, status: :created
      rescue => e
        # FIXME: log error and render jsonapi error
      end

      # def show
      #   render json: { api: 'OK' }
      # end

      def destroy
        if geolocation.destroy
          render json: { api: 'OK' }
        else
          render json: { api: 'ERROR' }
        end
      end

      private

      def create_params
        params.require(:geolocation).permit(:provider, :ip_or_hostname)
      end

      def geolocation
        @geolocation ||= Geolocation.find(params[:id])
      end
    end
  end
end
