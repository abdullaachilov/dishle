class ApplicationController < ActionController::API
  private

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
