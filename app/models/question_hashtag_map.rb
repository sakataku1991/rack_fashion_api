class QuestionHashtagMap < ApplicationRecord

  # 一つの「question_hashtag_map」は、ある一つの「質問」と
  belongs_to :question

  # ある一つの「ハッシュタグ」との関係性を示している
  belongs_to :hashtag

  # validates ########################

  validates :question_id,
    presence: true

  validates :hashtag_id,
    presence: true

end
