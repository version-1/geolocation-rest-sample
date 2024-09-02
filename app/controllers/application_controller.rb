class ApplicationController < ActionController::API
  include AuthMixin

  before_action :authenticate_user!

  # fallback all unexpected errors
  rescue_from StandardError do |e|
    log_error(e)
    render json: ErrorSerializer.internal_server_error(e), status: :internal_server_error
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    log_error(e)
    render json: ErrorSerializer.not_found(e), status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    log_error(e)
    render json: ErrorSerializer.record_invalid(e), status: :bad_request
  end

  def log_error(e)
    Rails.logger.error(e.message)
    Rails.logger.error(e.backtrace.join("\n"))
  end
end
