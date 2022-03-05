class QuestionColorMap < ApplicationRecord

  # 「question_color_map」は複数の「質問」と紐付いている
  belongs_to :question

  # 「question_color_map」は複数の「色」と紐付いている
  belongs_to :color

  # validates ########################

  validates :question_id,
    presence: true

  validates :color_id,
    presence: true

end
