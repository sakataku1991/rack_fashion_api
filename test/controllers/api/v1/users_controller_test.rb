require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = active_user
    @params = {
      auth: {
        name: @user.name,
        rack_id: @user.rack_id,
        email: @user.email,
        password: "password"
      }
    }
    @access_lifetime = UserAuth.access_token_lifetime
    @refresh_lifetime = UserAuth.refresh_token_lifetime
    @session_key = UserAuth.session_key.to_s
    @access_token_key = "token"
  end

  # tokenのリフレッシュを行うapi
  def refresh_api
    post api("/auth_token/refresh"), xhr: true
  end

  # 有効な会員登録
  test "valid_signup_from_create_action" do

  end

end
