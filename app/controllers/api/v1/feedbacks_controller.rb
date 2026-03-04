module Api
  module V1
    class FeedbacksController < ApplicationController
      include ActionController::Cookies

      def create
        body = feedback_params[:body]

        if body.blank? || body.length > 500
          return render json: { data: nil, error: "Body must be between 1 and 500 characters", meta: {} },
                        status: :unprocessable_entity
        end

        ip_address = request.remote_ip
        session_id = cookies[:dishle_session]

        # Generate a session cookie if not present
        if session_id.blank?
          session_id = SecureRandom.urlsafe_base64(32)
          cookies[:dishle_session] = {
            value: session_id,
            httponly: true,
            secure: Rails.env.production?,
            same_site: :lax,
            expires: 1.year.from_now
          }
        end

        # Cooldown check: 5 minutes per IP or session
        cooldown_scope = Feedback.where(ip_address: ip_address).where(created_at: 5.minutes.ago..)
        cooldown_scope = cooldown_scope.or(Feedback.where(session_id: session_id).where(created_at: 5.minutes.ago..)) if session_id.present?

        if cooldown_scope.exists?
          return render json: { data: nil, error: "Please wait before submitting more feedback", meta: {} },
                        status: :too_many_requests
        end

        feedback = Feedback.new(
          body: body,
          ip_address: ip_address,
          session_id: session_id,
          user: current_user
        )

        if feedback.save
          render json: { data: { submitted: true }, error: nil, meta: {} }, status: :created
        else
          render json: { data: nil, error: feedback.errors.full_messages.join(", "), meta: {} },
                      status: :unprocessable_entity
        end
      end

      private

      def feedback_params
        params.permit(:body)
      end
    end
  end
end
