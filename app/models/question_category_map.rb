class QuestionCategoryMap < ApplicationRecord

  # 「question_category_map」は複数の「質問」と紐付いている
  belongs_to :question

  # 「question_category_map」は複数の「カテゴリー」と紐付いている
  belongs_to :category

  # validates ########################

  validates :question_id,
    presence: true

  validates :category_id,
    presence: true

end
