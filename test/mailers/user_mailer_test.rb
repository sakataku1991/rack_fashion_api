require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = User.new(
      name: "test",
      email: "test@example.com",
      rack_id: "test_rack_id",
      password: "password"
    )
    user.save
    user.activation_token = User.new_token
    mail = user.email
    mail = UserMailer.account_activation(user)
    assert_equal "[RACK] 本登録のお願い", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    # assert_match user.name,               mail.body.encoded
    # assert_match user.activation_token,   mail.body.encoded
    # assert_match CGI.escape(user.email),  mail.body.encoded
  end

end
