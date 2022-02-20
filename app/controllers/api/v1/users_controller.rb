class Api::V1::UsersController < ApplicationController

  # 有効なアクセストークンが投げられない限り、リソースにアクセスできないようになるアクション
  # ログイン済みのユーザーにしかアクセスさせたくないリソースには以下のメソッドを使用すること！
  # before_action :authenticate_active_user

  # ユーザーの一覧の取得
  def index
    users = User.all
    render json:
      users.as_json(
        only: [
          :id,
          :name,
          :rack_id,
          :email,
          :created_at
        ]
      )
  end

end
