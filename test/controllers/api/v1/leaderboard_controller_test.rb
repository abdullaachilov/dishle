require "test_helper"

class Api::V1::LeaderboardControllerTest < ActionDispatch::IntegrationTest
  test "returns ranked entries" do
    get "/api/v1/leaderboard"
    assert_response :success
    entries = json_response["data"]["entries"]
    assert entries.is_a?(Array)
    assert entries.length > 0
    assert_equal 1, entries.first["rank"]
  end

  test "entries are sorted by total_points descending" do
    get "/api/v1/leaderboard"
    entries = json_response["data"]["entries"]
    points = entries.map { |e| e["total_points"] }
    assert_equal points.sort.reverse, points
  end

  test "entries include expected fields" do
    get "/api/v1/leaderboard"
    entry = json_response["data"]["entries"].first
    assert_not_nil entry["nickname"]
    assert_not_nil entry["total_points"]
    assert_not_nil entry["games_played"]
    assert_not_nil entry["games_won"]
    assert_not_nil entry["win_pct"]
    assert_not_nil entry["max_streak"]
  end
end
