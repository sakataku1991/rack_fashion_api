class QuestionCategoryMap < ApplicationRecord

  # 一つの「question_category_map」は、ある一つの「質問」と
  belongs_to :question

  # ある一つの「カテゴリー」との関係性を示している
  belongs_to :category

  # validates ########################

  validates :question_id,
    presence: true

  validates :category_id,
    presence: true

end
