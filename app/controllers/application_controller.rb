class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: ErrorSerilaizer.not_found(e), status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: ErrorSerilaizer.record_invalid(e), status: :bad_request
  end

  rescue_from StandardError do |e|
    return  render json: ErrorSerilaizer.internal_server_error(e), status: :internal_server_error if Rails.env.production?
  end
end
