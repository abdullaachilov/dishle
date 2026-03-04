require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "validates nickname format" do
    user = User.new(nickname: "bad name!", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:nickname], "only allows letters, numbers, and underscores"
  end

  test "validates nickname length minimum" do
    user = User.new(nickname: "ab", password: "password123")
    assert_not user.valid?
    assert user.errors[:nickname].any? { |e| e.include?("too short") }
  end

  test "validates nickname length maximum" do
    user = User.new(nickname: "a" * 21, password: "password123")
    assert_not user.valid?
    assert user.errors[:nickname].any? { |e| e.include?("too long") }
  end

  test "validates password minimum length" do
    user = User.new(nickname: "testuser", password: "short")
    assert_not user.valid?
    assert user.errors[:password].any? { |e| e.include?("too short") }
  end

  test "validates nickname uniqueness" do
    existing = users(:alice)
    user = User.new(nickname: existing.nickname, password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:nickname], "has already been taken"
  end

  test "generates session token on create" do
    user = User.create!(nickname: "newuser123", password: "password123")
    assert_not_nil user.session_token
  end

  test "generate_session_token! updates token" do
    user = users(:alice)
    old_token = user.session_token
    new_token = user.generate_session_token!
    assert_not_equal old_token, new_token
    assert_equal new_token, user.reload.session_token
  end

  test "invalidate_session! clears token" do
    user = users(:alice)
    user.invalidate_session!
    assert_nil user.reload.session_token
  end

  test "has_secure_password authenticates correctly" do
    user = users(:alice)
    assert user.authenticate("password123")
    assert_not user.authenticate("wrongpassword")
  end
end
