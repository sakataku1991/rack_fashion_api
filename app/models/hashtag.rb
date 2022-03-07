class Hashtag < ApplicationRecord

  # 「ハッシュタグ」が紐付いている「質問」（1対多）
  has_many :question_hashtag_maps,
    dependent: :destroy,
    foreign_key: 'hashtag_id'
  has_many :questions,
    through: :question_hashtag_maps

  # validates ########################

  # 「ハッシュタグ名」のバリデーション
  validates :name,
    presence: true,                  # 入力必須。空白文字を許容しない。
    uniqueness: true,
    length: {                        # 文字数の制限
      maximum: 100,                  # 最大文字数
      allow_blank: true              # 「allow_blank: true」を付けることで、「nil（空白文字）」の場合にはこの検証をスキップする
    }

end
