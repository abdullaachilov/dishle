module Api
  module V1
    class LeaderboardController < ApplicationController
      def index
        users = User
          .where("games_played > 0")
          .order(games_won: :desc, max_streak: :desc)
          .limit(50)
          .select(:nickname, :games_played, :games_won, :current_streak, :max_streak)

        render json: {
          data: {
            entries: users.map.with_index(1) do |u, rank|
              {
                rank: rank,
                nickname: u.nickname,
                games_played: u.games_played,
                games_won: u.games_won,
                win_pct: u.games_played > 0 ? (u.games_won * 100.0 / u.games_played).round : 0,
                current_streak: u.current_streak,
                max_streak: u.max_streak
              }
            end
          },
          error: nil,
          meta: {}
        }
      end
    end
  end
end
