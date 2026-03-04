module Api
  module V1
    class GameResultsController < ApplicationController
      before_action :authenticate!

      def create
        date_str = result_params[:date].to_s
        solved = result_params[:solved]
        guesses_count = result_params[:guesses_count].to_i

        if date_str.blank? || date_str.length > 20
          render json: { data: nil, error: "Invalid parameters", meta: {} }, status: :unprocessable_entity
          return
        end

        begin
          date = Date.parse(date_str)
        rescue Date::Error
          render json: { data: nil, error: "Invalid date format", meta: {} }, status: :unprocessable_entity
          return
        end

        puzzle = DailyPuzzle.for_date(date)
        unless puzzle
          render json: { data: nil, error: "No puzzle for this date", meta: {} }, status: :not_found
          return
        end

        existing = GameResult.find_by(user: current_user, daily_puzzle: puzzle)
        if existing
          render json: { data: { submitted: true }, error: nil, meta: {} }
          return
        end

        is_solved = solved == true || solved == "true"
        result = GameResult.new(
          user: current_user,
          daily_puzzle: puzzle,
          solved: is_solved,
          guesses_count: guesses_count.clamp(1, 6),
          completed_at: Time.current
        )

        if result.save
          update_user_stats!(current_user, result)
          render json: { data: { submitted: true }, error: nil, meta: {} }, status: :created
        else
          render json: {
            data: nil,
            error: result.errors.full_messages.first,
            meta: {}
          }, status: :unprocessable_entity
        end
      end

      private

      def result_params
        params.permit(:date, :solved, :guesses_count)
      end

      def update_user_stats!(user, result)
        user.games_played += 1
        if result.solved
          user.games_won += 1
          user.current_streak += 1
          user.max_streak = [user.max_streak, user.current_streak].max
        else
          user.current_streak = 0
        end
        user.save!
      end
    end
  end
end
