class ApplicationController < ActionController::API
  # fallback all unexpected errors
  rescue_from StandardError do |e|
    raise e unless Rails.env.production?

    render json: ErrorSerilaizer.internal_server_error(e), status: :internal_server_error
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: ErrorSerializer.not_found(e), status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: ErrorSerializer.record_invalid(e), status: :bad_request
  end
end
