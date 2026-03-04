require "test_helper"

class Api::V1::FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test "creates feedback with valid body" do
    json_post "/api/v1/feedback", params: { body: "Nice game!" }
    assert_response :created
    assert json_response["data"]["submitted"]
  end

  test "rejects empty body" do
    json_post "/api/v1/feedback", params: { body: "" }
    assert_response :unprocessable_entity
  end

  test "rejects body over 500 characters" do
    json_post "/api/v1/feedback", params: { body: "a" * 501 }
    assert_response :unprocessable_entity
  end
end
