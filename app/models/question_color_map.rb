class QuestionColorMap < ApplicationRecord

  # 一つの「question_color_map」は、ある一つの「質問」と
  belongs_to :question

  # ある一つの「色」との関係性を示している
  belongs_to :color

  # validates ########################

  validates :question_id,
    presence: true

  validates :color_id,
    presence: true

end
