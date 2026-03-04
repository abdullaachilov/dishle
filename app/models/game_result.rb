class GameResult < ApplicationRecord
  belongs_to :user
  belongs_to :daily_puzzle

  validates :guesses_count, presence: true, inclusion: { in: 1..6 }
  validates :solved, inclusion: { in: [true, false] }
  validates :completed_at, presence: true
  validates :user_id, uniqueness: { scope: :daily_puzzle_id }
  validates :hints_used, inclusion: { in: 0..2 }
end
