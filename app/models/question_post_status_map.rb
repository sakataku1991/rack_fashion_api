class QuestionPostStatusMap < ApplicationRecord

  # 一つの「question_post_status_map」は、ある一つの「質問」と
  belongs_to :question

  # ある一つの「公開状況」との関係性を示している
  belongs_to :post_status

  # validates ########################

  validates :question_id,
    presence: true

  validates :post_status_id,
    presence: true

end
