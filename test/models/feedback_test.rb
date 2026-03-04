require "test_helper"

class FeedbackTest < ActiveSupport::TestCase
  test "validates body presence" do
    feedback = Feedback.new(ip_address: "127.0.0.1")
    assert_not feedback.valid?
    assert_includes feedback.errors[:body], "can't be blank"
  end

  test "validates body maximum length" do
    feedback = Feedback.new(body: "a" * 501, ip_address: "127.0.0.1")
    assert_not feedback.valid?
    assert feedback.errors[:body].any? { |e| e.include?("too long") }
  end

  test "validates ip_address presence" do
    feedback = Feedback.new(body: "Great game!")
    assert_not feedback.valid?
    assert_includes feedback.errors[:ip_address], "can't be blank"
  end

  test "valid feedback saves successfully" do
    feedback = Feedback.new(body: "Fun game!", ip_address: "192.168.1.1")
    assert feedback.valid?
    assert feedback.save
  end
end
