class PostStatus < ApplicationRecord

  # 「公開状況」が紐付いている「質問」（1対多）
  # has_many :question_post_status_maps,
  #   dependent: :destroy,
  #   foreign_key: 'post_status_id'
  # has_many :questions,
  #   through: :question_post_status_maps
  has_many :questions

  # validates ########################

  validates :name,
    presence: true,
    uniqueness: true

  validates :code,
    presence: true,
    uniqueness: true

end
