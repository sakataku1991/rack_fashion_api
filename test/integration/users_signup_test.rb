require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  # 有効なユーザーが登録できているか？
  test "create_user_validation" do
    user = User.new(
      name: "test",
      email: "test@example.com",
      rack_id: "test_rack_id",
      password: "password"
    )
    assert_difference("User.count", 1) do
      user.save
    end
  end

end
