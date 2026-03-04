require "test_helper"

class Api::V1::GameResultsControllerTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    json_post "/api/v1/game_results", params: { date: Date.current.iso8601, solved: true, guesses_count: 3 }
    assert_response :unauthorized
  end

  test "creates result with valid params" do
    user = users(:bob)
    json_post "/api/v1/game_results",
      params: { date: Date.current.iso8601, solved: true, guesses_count: 3, hints_used: 0 },
      headers: auth_headers(user)
    assert_response :created
    assert json_response["data"]["submitted"]
  end

  test "returns ok for duplicate submission" do
    user = users(:alice)
    yesterday = (Date.current - 1).iso8601
    json_post "/api/v1/game_results",
      params: { date: yesterday, solved: true, guesses_count: 3 },
      headers: auth_headers(user)
    assert_response :success
    assert json_response["data"]["submitted"]
  end

  test "updates user stats on win" do
    user = users(:bob)
    old_points = user.total_points
    old_won = user.games_won

    json_post "/api/v1/game_results",
      params: { date: Date.current.iso8601, solved: true, guesses_count: 2, hints_used: 0 },
      headers: auth_headers(user)
    assert_response :created

    user.reload
    assert_equal old_won + 1, user.games_won
    assert_equal old_points + 5, user.total_points  # 2nd try = 5 points
  end

  test "applies hint penalty to points" do
    user = users(:bob)
    old_points = user.total_points

    json_post "/api/v1/game_results",
      params: { date: Date.current.iso8601, solved: true, guesses_count: 2, hints_used: 2 },
      headers: auth_headers(user)
    assert_response :created

    user.reload
    # 2nd try = 5 base - 2*2 hint penalty = 1 point
    assert_equal old_points + 1, user.total_points
  end

  test "resets streak on loss" do
    user = users(:bob)
    assert user.current_streak > 0

    json_post "/api/v1/game_results",
      params: { date: Date.current.iso8601, solved: false, guesses_count: 6 },
      headers: auth_headers(user)
    assert_response :created

    user.reload
    assert_equal 0, user.current_streak
  end
end
