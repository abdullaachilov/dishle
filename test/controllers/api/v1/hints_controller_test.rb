require "test_helper"

class Api::V1::HintsControllerTest < ActionDispatch::IntegrationTest
  test "returns next unrevealed slot" do
    puzzle = daily_puzzles(:today_puzzle)
    first_hint_slot = Dish::INGREDIENT_SLOTS[puzzle.puzzle_number % 5]

    json_post "/api/v1/hint", params: { date: Date.current.iso8601, revealed: [first_hint_slot] }
    assert_response :success
    data = json_response["data"]
    assert_includes Dish::INGREDIENT_SLOTS, data["slot"]
    assert_not_equal first_hint_slot, data["slot"]
    assert_not_nil data["value"]
  end

  test "respects max hints limit" do
    json_post "/api/v1/hint", params: {
      date: Date.current.iso8601,
      revealed: %w[base protein star]
    }
    assert_response :unprocessable_entity
    assert_includes json_response["error"], "Maximum hints reached"
  end

  test "returns 404 for invalid date" do
    json_post "/api/v1/hint", params: { date: "2099-01-01", revealed: [] }
    assert_response :not_found
  end

  test "returns 422 for missing date" do
    json_post "/api/v1/hint", params: { date: "", revealed: [] }
    assert_response :unprocessable_entity
  end

  test "filters invalid slot names from revealed" do
    puzzle = daily_puzzles(:today_puzzle)
    first_hint_slot = Dish::INGREDIENT_SLOTS[puzzle.puzzle_number % 5]

    json_post "/api/v1/hint", params: {
      date: Date.current.iso8601,
      revealed: [first_hint_slot, "invalid_slot", "another_fake"]
    }
    assert_response :success
    data = json_response["data"]
    assert_equal 2, data["hints_used"]
  end
end
