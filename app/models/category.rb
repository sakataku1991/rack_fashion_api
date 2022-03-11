class Category < ApplicationRecord

  # 「カテゴリー」が紐付いている「質問」（多対多）
  # has_many :question_category_maps,
  #   dependent: :destroy,
  #   foreign_key: 'category_id'
  # has_many :questions,
  #   through: :question_category_maps
  has_many :questions

  # validates ########################

  validates :name,
    presence: true,
    uniqueness: true

  validates :code,
    presence: true,
    uniqueness: true

end
