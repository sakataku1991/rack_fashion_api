require "test_helper"

class QuestionTest < ActiveSupport::TestCase

    # 「質問」のテストヘルパーの呼び出し
    def setup
      @user = users(:user0)
    end

  # 「ユーザーID」のバリデーションのテスト
  test "user_id_validation" do
    # 存在しているかどうか
    question = Question.new(
      user_id: ""
      image: "",
      title: "テスト質問のタイトル",
      body: "テスト質問の本文"
    )
    user.save
    question.user_id = nil
    assert_not question.valid?
  end

  # 「質問のタイトル」のバリデーションのテスト
  test "title_validation" do
    # この属性の日本語名
    attribute_ja = "質問のタイトル"

    # 入力必須
    question = Question.new(
      user_id: 01
      image: "",
      title: "",
      body: "テスト質問の本文"
    )
    user.save
    required_msg = ["#{attribute_ja}を入力してください"]
    assert_equal(required_msg, user.errors.full_messages)

    # 文字数制限・最大文字数
    max = 50
    title = "a" * (min - 1)
    user.title = title
    user.save
    minlength_msg = ["#{attribute_ja}は#{min}文字以上で入力してください"]
    assert_equal(minlength_msg, user.errors.full_messages)
  end

  # 「質問の内容」のバリデーションのテスト
  test "body_validation" do
    # この属性の日本語名
    attribute_ja = "質問の内容"

    # 入力必須
    question = Question.new(
      user_id: 01
      image: "",
      title: "テスト質問のタイトル",
      body: ""
    )
    user.save
    required_msg = ["#{attribute_ja}を入力してください"]
    assert_equal(required_msg, user.errors.full_messages)

    # 文字数制限・最大文字数
    max = 2000
    body = "a" * (min - 1)
    user.body = body
    user.save
    minlength_msg = ["#{attribute_ja}は#{min}文字以上で入力してください"]
    assert_equal(minlength_msg, user.errors.full_messages)
  end

end
