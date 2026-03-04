require "test_helper"

class Api::V1::PuzzlesControllerTest < ActionDispatch::IntegrationTest
  test "today returns puzzle with hint" do
    get "/api/v1/today"
    assert_response :success
    data = json_response["data"]
    assert_equal 1, data["puzzle_number"]
    assert_not_nil data["hint"]
    assert_includes Dish::INGREDIENT_SLOTS, data["hint"]["slot"]
  end

  test "guess with valid dish returns comparison" do
    json_post "/api/v1/guess", params: { guess: "bolognese", date: Date.current.iso8601 }
    assert_response :success
    data = json_response["data"]
    assert data["valid"]
    assert_equal "Bolognese", data["dish_name"]
    assert_not_nil data["ingredients"]
    assert_equal "correct", data["ingredients"]["base"]["result"]  # Both pasta
  end

  test "guess with correct dish returns solved true" do
    json_post "/api/v1/guess", params: { guess: "carbonara", date: Date.current.iso8601 }
    assert_response :success
    data = json_response["data"]
    assert data["solved"]
  end

  test "guess with unknown dish returns valid false" do
    json_post "/api/v1/guess", params: { guess: "nonexistent-dish", date: Date.current.iso8601 }
    assert_response :success
    assert_not json_response["data"]["valid"]
  end

  test "guess with missing params returns 422" do
    json_post "/api/v1/guess", params: { guess: "" }
    assert_response :unprocessable_entity
  end

  test "reveal returns dish details including fun_fact" do
    slugs = Array.new(6, "wrong-dish").join(",")
    get "/api/v1/reveal", params: { date: Date.current.iso8601, guesses: slugs }
    assert_response :success
    data = json_response["data"]
    assert_equal "Carbonara", data["dish_name"]
    assert_equal "Italian", data["cuisine"]
    assert_not_nil data["fun_fact"]
  end

  test "reveal with correct guess returns dish details" do
    get "/api/v1/reveal", params: { date: Date.current.iso8601, guesses: "carbonara" }
    assert_response :success
    assert_equal "Carbonara", json_response["data"]["dish_name"]
  end

  test "reveal blocks access without enough guesses" do
    get "/api/v1/reveal", params: { date: Date.current.iso8601, guesses: "wrong-dish" }
    assert_response :forbidden
  end
end
