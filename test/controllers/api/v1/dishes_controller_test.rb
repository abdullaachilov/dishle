require "test_helper"

class Api::V1::DishesControllerTest < ActionDispatch::IntegrationTest
  test "search returns results for valid query" do
    get "/api/v1/dishes/search", params: { q: "carb" }
    assert_response :success
    results = json_response["data"]["results"]
    assert results.is_a?(Array)
    assert results.any? { |r| r["name"] == "Carbonara" }
  end

  test "search returns empty for no match" do
    get "/api/v1/dishes/search", params: { q: "zzzzzzz" }
    assert_response :success
    assert_empty json_response["data"]["results"]
  end

  test "search returns empty for short query" do
    get "/api/v1/dishes/search", params: { q: "a" }
    assert_response :success
    assert_empty json_response["data"]["results"]
  end
end
