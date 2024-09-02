module AuthMixin
  def current_user
    @current_user
  end

  def authenticate_user!
    raw = request.headers['Authorization']
    return render_unauthorized unless raw.present?

    token = raw.split(' ').last
    return render_unauthorized unless token.present?

    jwt = Auth::Jwt.decode(token)

    @current_user = User.find_by(email: jwt[0]['sub'])

    render_unauthorized unless @current_user.present?
  rescue JWT::DecodeError => e
    Rails.logger.error(e.message)
    Rails.logger.error(e.backtrace.join("\n"))

    render_unauthorized
  end

  private

  def render_unauthorized
    render json: ErrorSerializer.unauthorized, status: :unauthorized
  end
end
