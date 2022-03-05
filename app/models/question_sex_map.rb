class QuestionSexMap < ApplicationRecord

  # 「question_sex_map」は複数の「質問」と紐付いている
  belongs_to :question

  # 「question_sex_map」は複数の「性別」と紐付いている
  belongs_to :sex

  # validates ########################

  validates :question_id,
    presence: true

  validates :sex_id,
    presence: true

end
