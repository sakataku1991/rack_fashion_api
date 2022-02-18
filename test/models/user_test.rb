require "test_helper"

class UserTest < ActiveSupport::TestCase

  # 「ユーザー」のテストヘルパーの呼び出し
  def setup
    @user = active_user
  end

  # 「ユーザー名」のバリデーションのテスト
  test "name_validation" do
    # 入力必須
    user = User.new(
      name: "",
      email: "test@example.com",
      rack_id: "test_rack_id",
      password: "password"
    )
    user.save
    required_msg = ["名前を入力してください"]
    assert_equal(required_msg, user.errors.full_messages)

    # 文字数制限・最大文字数
    max = 30
    name = "a" * (max + 1)
    user.name = name
    user.save
    maxlength_msg = ["名前は#{max}文字以内で入力してください"]
    assert_equal(maxlength_msg, user.errors.full_messages)

    # 30文字以内のユーザーは保存できているか
    name = "あ" * max
    user.name = name
    assert_difference("User.count", 1) do
      user.save
    end
  end

  # 「RACK ID」のバリデーションのテスト
  test "rack_id_validation" do
    # 入力必須
    user = User.new(
      name: "test",
      rack_id: "",
      email: "test@example.com",
      password: "password"
    )
    user.save
    required_msg = ["RACK IDを入力してください"]
    assert_equal(required_msg, user.errors.full_messages)

    # 文字数制限・最小文字数
    min = 3
    rack_id = "a" * (min - 1)
    user.rack_id = rack_id
    user.save
    minlength_msg = ["RACK IDは#{min}文字以上で入力してください"]
    assert_equal(minlength_msg, user.errors.full_messages)

    # 3文字以上のユーザーは保存できているか
    rack_id = "a" * min
    user.rack_id = rack_id
    assert_difference("User.count", 1) do
      user.save
    end

    # 文字数制限・最大文字数
    max = 16
    rack_id = "a" * (max + 1)
    user.rack_id = rack_id
    user.save
    maxlength_msg = ["RACK IDは#{max}文字以内で入力してください"]
    assert_equal(maxlength_msg, user.errors.full_messages)

    # 16文字以内のユーザーは保存できているか
    rack_id = "a" * max
    user.rack_id = rack_id
    assert_difference("User.count", 0) do  # TODO 後で直す！
      user.save
    end

    # 書式チェック・VALID_RACK_ID_REGEX = /\A[a-zA-Z0-9_]+\z/
    ok_rack_ids = %w(
      rack___id
      ___
      123
      __r
      r__
      rac
    )
    ok_rack_ids.each do |rack_id|
      user.rack_id = rack_id
      assert user.save
    end
    ng_rack_ids = %w(
      r/a
      r.a
      -|~=?+"a"
      １２３
      ＡＢＣ
      ra@
    )
    format_msg = ["RACK IDは半角英数字・アンダースコアが使えます"]
    ng_rack_ids.each do |rack_id|
      user.rack_id = rack_id
      user.save
      assert_equal(format_msg, user.errors.full_messages)
    end
  end

  # 「RACK ID」の小文字化のテスト
  test "rack_id_downcase" do
    rack_id = "EXAMPLE_RACK_ID"
    user = User.new(
      name: "test",
      rack_id: rack_id,
      email: "test@example.com",
      password: "password"
    )
    user.save
    assert user.rack_id == rack_id.downcase
  end

  # 「RACK ID」の一意性のテスト
  test "active_user_rack_id_uniqueness" do
    rack_id = "test_rack_id"

    # アクティブユーザー = activated: true

    # アクティブユーザーがいない場合、同じ「RACK ID」が保存できているか
    count = 3
    assert_difference("User.count", count) do
      count.times do |n|
        User.create(
          name: "test",
          rack_id: rack_id,
          email: "test#{n}@example.com",
          password: "password"
        )
      end
    end

    # アクティブユーザーがいる場合、同じ「RACK ID」でバリデーションエラーを吐いているか
    active_user = User.find_by(rack_id: rack_id)
    active_user.update!(activated: true)
    assert active_user.activated

    assert_no_difference("User.count") do
      user = User.new(
        name: "test",
        rack_id: rack_id,
        email: "test3@example.com",
        password: "password"
      )
      user.save
      uniqueness_msg = ["RACK IDはすでに存在します"]
      assert_equal(uniqueness_msg, user.errors.full_messages)
    end

    # アクティブユーザーがいなくなった場合、同じ「RACK ID」が保存できているか
    active_user.destroy!
    assert_difference("User.count", 1) do
      User.create(
        name: "test",
        rack_id: rack_id,
        email: "test3@example.com",
        password: "password",
        activated: true
      )
    end

    # アクティブユーザーの「RACK ID」の一意性は保たれているか？
    assert_equal(1, User.where(rack_id: rack_id, activated: true).count)
  end

  # 「メールアドレス」のバリデーションのテスト
  test "email_validation" do
    # 入力必須
    user = User.new(
      name: "test",
      rack_id:
      "test_rack_id",
      email: "",
      password: "password"
    )
    user.save
    required_msg = ["メールアドレスを入力してください"]
    assert_equal(required_msg, user.errors.full_messages)

    # 文字数制限・最大文字数
    max = 255
    domain = "@example.com"
    email = "a" * (max + 1 - domain.length) + domain
    assert max < email.length
    user.email = email
    user.save
    maxlength_msg = ["メールアドレスは#{max}文字以内で入力してください"]
    assert_equal(maxlength_msg, user.errors.full_messages)

    # 書式チェック・メールアドレスの形式
    ok_emails = %w(
      A@EX.COM
      a-_@e-x.c-o_m.j_p
      a.a@ex.com
      a@e.co.js
      1.1@ex.com
      a.a+a@ex.com
    )
    ok_emails.each do |email|
      user.email = email
      assert user.save
    end
    ng_emails = %w(
      aaa
      a.ex.com
      メール@ex.com
      a~a@ex.com
      a@|.com
      a@ex.
      .a@ex.com
      a＠ex.com
      Ａ@ex.com
      a@?,com
      １@ex.com
      "a"@ex.com
      a@ex@co.jp
    )
    ng_emails.each do |email|
      user.email = email
      user.save
      format_msg = ["メールアドレスは不正な値です"]
      assert_equal(format_msg, user.errors.full_messages)
    end
  end

  # 「メールアドレス」の小文字化のテスト
  test "email_downcase" do
    email = "USER@EXAMPLE.COM"
    user = User.new(email: email)
    user.save
    assert user.email == email.downcase
  end

  # 「メールアドレス」の一意性のテスト
  test "active_user_email_uniqueness" do
    email = "test@example.com"

    # アクティブユーザー = activated: true

    # アクティブユーザーがいない場合、同じ「メールアドレス」が保存できているか
    count = 3
    assert_difference("User.count", count) do
      count.times do |n|
        User.create(
          name: "test",
          rack_id: "test_rack_id#{n}",
          email: email,
          password: "password"
        )
      end
    end

    # アクティブユーザーがいる場合、同じ「メールアドレス」でバリデーションエラーを吐いているか
    active_user = User.find_by(email: email)
    active_user.update!(activated: true)
    assert active_user.activated

    assert_no_difference("User.count") do
      user = User.new(
        name: "test",
        rack_id: "test_rack_id3",
        email: email,
        password: "password"
      )
      user.save
      uniqueness_msg = ["メールアドレスはすでに存在します"]
      assert_equal(uniqueness_msg, user.errors.full_messages)
    end

    # アクティブユーザーがいなくなった場合、同じ「メールアドレス」が保存できているか
    active_user.destroy!
    assert_difference("User.count", 1) do
      User.create(
        name: "test",
        rack_id: "test_rack_id3",
        email: email,
        password: "password",
        activated: true
      )
    end

    # アクティブユーザーの「メールアドレス」の一意性は保たれているか？
    assert_equal(1, User.where(email: email, activated: true).count)
  end

  # 「パスワード」のバリデーションのテスト
  test "password_validation" do
    # 入力必須
    user = User.new(
      name: "test",
      rack_id: "test_rack_id",
      email: "test@example.com",
      password: ""
    )
    user.save
    required_msg = ["パスワードを入力してください"]
    assert_equal(required_msg, user.errors.full_messages)

    # 文字数制限・最小文字数
    min = 8
    user.password = "a" * (min - 1)
    user.save
    minlength_msg = ["パスワードは#{min}文字以上で入力してください"]
    assert_equal(minlength_msg, user.errors.full_messages)

    # 文字数制限・最大文字数
    max = 72
    user.password = "a" * (max + 1)
    user.save
    maxlength_msg = ["パスワードは#{max}文字以内で入力してください"]
    assert_equal(maxlength_msg, user.errors.full_messages)

    # 書式チェック・VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
    ok_passwords = %w(
      pass---word
      ________
      12341234
      ____pass
      pass----
      PASSWORD
    )
    ok_passwords.each do |pass|
      user.password = pass
      assert user.save
    end
    ng_passwords = %w(
      pass/word
      pass.word
      |~=?+"a"
      １２３４５６７８
      ＡＢＣＤＥＦＧＨ
      password@
    )
    format_msg = ["パスワードは半角英数字・ハイフン・アンダースコアが使えます"]
    ng_passwords.each do |pass|
      user.password = pass
      user.save
      assert_equal(format_msg, user.errors.full_messages)
    end
  end

end
