class QuestionSexMap < ApplicationRecord

  # 一つの「question_sex_map」は、ある一つの「質問」と
  belongs_to :question

  # ある一つの「性別」との関係性を示している
  belongs_to :sex

  # validates ########################

  validates :question_id,
    presence: true

  validates :sex_id,
    presence: true

end
