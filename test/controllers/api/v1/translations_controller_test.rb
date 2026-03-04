require "test_helper"

class Api::V1::TranslationsControllerTest < ActionDispatch::IntegrationTest
  test "returns translations for valid locale" do
    get "/api/v1/translations", params: { locale: "ru" }
    assert_response :success
    data = json_response["data"]
    assert_not_nil data["ingredients"]
  end

  test "returns catalog for english locale" do
    get "/api/v1/translations", params: { locale: "en" }
    assert_response :success
    data = json_response["data"]
    assert_not_nil data["catalog"]
  end

  test "returns error for invalid locale" do
    get "/api/v1/translations", params: { locale: "xx" }
    assert_response :unprocessable_entity
  end
end
