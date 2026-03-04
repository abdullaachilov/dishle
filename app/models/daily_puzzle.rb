class DailyPuzzle < ApplicationRecord
  belongs_to :dish

  validates :puzzle_date, presence: true, uniqueness: true
  validates :puzzle_number, presence: true, uniqueness: true

  scope :for_date, ->(date) { find_by(puzzle_date: date) }

  def self.today
    for_date(Date.current)
  end
end
