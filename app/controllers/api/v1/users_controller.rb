class Api::V1::UsersController < ApplicationController

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
