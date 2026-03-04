class ApplicationController < ActionController::API
  before_action :set_security_headers

  private

  def set_security_headers
    response.set_header("X-Content-Type-Options", "nosniff")
    response.set_header("X-Frame-Options", "DENY")
    response.set_header("X-XSS-Protection", "0")
    response.set_header("Referrer-Policy", "strict-origin-when-cross-origin")
    response.set_header("Permissions-Policy", "camera=(), microphone=(), geolocation=()")
    response.set_header("Content-Security-Policy", "default-src 'none'; frame-ancestors 'none'")
    response.set_header("Strict-Transport-Security", "max-age=31536000; includeSubDomains") if request.ssl?
  end

  def current_user
    return @current_user if defined?(@current_user)

    token = request.headers["Authorization"]&.delete_prefix("Bearer ")&.strip
    return @current_user = nil if token.blank?

    user = User.find_by(session_token: token)
    if user && ActiveSupport::SecurityUtils.secure_compare(user.session_token, token)
      @current_user = user
    else
      @current_user = nil
    end
  end

  def authenticate!
    unless current_user
      render json: { data: nil, error: "Authentication required", meta: {} }, status: :unauthorized
    end
  end
end
