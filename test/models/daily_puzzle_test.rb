require "test_helper"

class DailyPuzzleTest < ActiveSupport::TestCase
  test "validates puzzle_date uniqueness" do
    existing = daily_puzzles(:today_puzzle)
    puzzle = DailyPuzzle.new(dish: dishes(:pad_thai), puzzle_date: existing.puzzle_date, puzzle_number: 999)
    assert_not puzzle.valid?
    assert_includes puzzle.errors[:puzzle_date], "has already been taken"
  end

  test "validates puzzle_number uniqueness" do
    existing = daily_puzzles(:today_puzzle)
    puzzle = DailyPuzzle.new(dish: dishes(:pad_thai), puzzle_date: Date.current + 30, puzzle_number: existing.puzzle_number)
    assert_not puzzle.valid?
    assert_includes puzzle.errors[:puzzle_number], "has already been taken"
  end

  test "for_date scope returns puzzle for given date" do
    puzzle = DailyPuzzle.for_date(Date.current)
    assert_equal daily_puzzles(:today_puzzle), puzzle
  end

  test "today returns today's puzzle" do
    puzzle = DailyPuzzle.today
    assert_equal daily_puzzles(:today_puzzle), puzzle
  end

  test "belongs to dish" do
    puzzle = daily_puzzles(:today_puzzle)
    assert_equal dishes(:carbonara), puzzle.dish
  end
end
