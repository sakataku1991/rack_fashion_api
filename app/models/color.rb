class Color < ApplicationRecord

  # 「色」が紐付いている「質問」（多対多）
  has_many :question_color_maps,
    dependent: :destroy,
    foreign_key: 'color_id'
  has_many :questions,
    through: :question_color_maps

  # validates ########################

  validates :name,
    presence: true,
    uniqueness: true

  validates :code,
    presence: true,
    uniqueness: true

end
