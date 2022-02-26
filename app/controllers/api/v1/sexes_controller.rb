class Api::V1::SexesController < ApplicationController

  # 「性別」の一覧の取得
  def index
    @sex = Sex.all
    render json:
      @sex.as_json(
        only: [
          :sex,
          :code
        ]
      )
  end

  # 「性別」の表示
  def show
  end

end
