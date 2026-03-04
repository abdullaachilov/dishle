module Api
  module V1
    class AuthController < ApplicationController
      before_action :authenticate!, only: [:me, :logout]

      def register
        nickname = auth_params[:nickname].to_s
        password = auth_params[:password].to_s

        if nickname.length > 20 || password.length > 72
          render json: { data: nil, error: "Invalid parameters", meta: {} }, status: :unprocessable_entity
          return
        end

        user = User.new(nickname: nickname, password: password, password_confirmation: password)

        if user.save
          render json: {
            data: {
              token: user.session_token,
              user: user_json(user)
            },
            error: nil,
            meta: {}
          }, status: :created
        else
          render json: {
            data: nil,
            error: user.errors.full_messages.first,
            meta: {}
          }, status: :unprocessable_entity
        end
      end

      def login
        nickname = auth_params[:nickname].to_s
        password = auth_params[:password].to_s

        if nickname.length > 20 || password.length > 72
          render json: { data: nil, error: "Invalid credentials", meta: {} }, status: :unauthorized
          return
        end

        user = User.find_by(nickname: nickname)

        if user&.authenticate(password)
          token = user.generate_session_token!
          render json: {
            data: {
              token: token,
              user: user_json(user)
            },
            error: nil,
            meta: {}
          }
        else
          render json: {
            data: nil,
            error: "Invalid credentials",
            meta: {}
          }, status: :unauthorized
        end
      end

      def logout
        current_user.invalidate_session!
        render json: { data: nil, error: nil, meta: {} }
      end

      def me
        render json: {
          data: { user: user_json(current_user) },
          error: nil,
          meta: {}
        }
      end

      private

      def auth_params
        params.permit(:nickname, :password)
      end

      def user_json(user)
        {
          nickname: user.nickname,
          games_played: user.games_played,
          games_won: user.games_won,
          current_streak: user.current_streak,
          max_streak: user.max_streak,
          total_points: user.total_points
        }
      end
    end
  end
end
