require "test_helper"

class GameResultTest < ActiveSupport::TestCase
  test "validates guesses_count in range" do
    result = GameResult.new(user: users(:alice), daily_puzzle: daily_puzzles(:today_puzzle),
                           solved: true, guesses_count: 7, hints_used: 0, completed_at: Time.current)
    assert_not result.valid?
    assert_includes result.errors[:guesses_count], "is not included in the list"
  end

  test "validates hints_used in range" do
    result = GameResult.new(user: users(:alice), daily_puzzle: daily_puzzles(:today_puzzle),
                           solved: true, guesses_count: 3, hints_used: 5, completed_at: Time.current)
    assert_not result.valid?
    assert_includes result.errors[:hints_used], "is not included in the list"
  end

  test "validates user_id uniqueness per puzzle" do
    existing = game_results(:alice_yesterday)
    result = GameResult.new(user: existing.user, daily_puzzle: existing.daily_puzzle,
                           solved: true, guesses_count: 2, hints_used: 0, completed_at: Time.current)
    assert_not result.valid?
    assert_includes result.errors[:user_id], "has already been taken"
  end

  test "valid result saves successfully" do
    result = GameResult.new(user: users(:bob), daily_puzzle: daily_puzzles(:today_puzzle),
                           solved: true, guesses_count: 4, hints_used: 1, completed_at: Time.current)
    assert result.valid?
    assert result.save
  end
end
