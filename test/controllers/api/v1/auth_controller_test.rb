require "test_helper"

class Api::V1::AuthControllerTest < ActionDispatch::IntegrationTest
  test "register creates user and returns token" do
    json_post "/api/v1/auth/register", params: { nickname: "newplayer", password: "password123" }
    assert_response :created
    data = json_response["data"]
    assert_not_nil data["token"]
    assert_equal "newplayer", data["user"]["nickname"]
  end

  test "register fails with duplicate nickname" do
    user = users(:alice)
    json_post "/api/v1/auth/register", params: { nickname: user.nickname, password: "password123" }
    assert_response :unprocessable_entity
  end

  test "register fails with short password" do
    json_post "/api/v1/auth/register", params: { nickname: "shortpw", password: "short" }
    assert_response :unprocessable_entity
  end

  test "login succeeds with correct credentials" do
    json_post "/api/v1/auth/login", params: { nickname: "alice_test", password: "password123" }
    assert_response :success
    data = json_response["data"]
    assert_not_nil data["token"]
    assert_equal "alice_test", data["user"]["nickname"]
  end

  test "login fails with wrong password" do
    json_post "/api/v1/auth/login", params: { nickname: "alice_test", password: "wrongpassword" }
    assert_response :unauthorized
  end

  test "logout invalidates session" do
    user = users(:alice)
    json_delete "/api/v1/auth/logout", headers: auth_headers(user)
    assert_response :success
    assert_nil user.reload.session_token
  end

  test "me returns current user" do
    user = users(:alice)
    get "/api/v1/auth/me", headers: auth_headers(user)
    assert_response :success
    assert_equal user.nickname, json_response["data"]["user"]["nickname"]
  end

  test "me returns 401 without token" do
    get "/api/v1/auth/me"
    assert_response :unauthorized
  end
end
