class Api::V1::QuestionsController < ApplicationController

  # 有効なアクセストークンが投げられない限り、リソースにアクセスできないようになるアクション
  before_action :authenticate_active_user

  def index
    questions = []
    date = Date.new(2021,4,1)
    10.times do |n|
      id = n + 1
      name = "#{current_user.name} question #{id.to_s.rjust(2, "0")}"
      author_rack_id = "#{current_user.rack_id}"
      title = "質問のタイトル"
      updated_at = date + (id * 6).hours
      questions << {
        id: id,
        name: name,
        author_rack_id: author_rack_id,
        title: title,
        updatedAt: updated_at
      }
    end
    # updated_at = date + (id * 6).hours
    # 本来はcurrent_user.questions
    render json: questions
  end

end
