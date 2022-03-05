class Question < ApplicationRecord

  # 「質問」は必ずある一人の「ユーザー」に紐付いている（1対1）
  belongs_to :user

  # 「質問」を新しい順で取得
  default_scope -> { order(created_at: :desc) }

  # 「質問」は必ずある一つの「性別」に紐付いている（1対1）
  # オプション: 質問の削除時に、その質問の性別も同時に削除する
  has_one :question_sex_map,
    dependent: :destroy
  has_one :sex,
    through: :question_sex_map

  # 「質問」は必ずある一つの「カテゴリー」に紐付いている（1対1）
  # オプション: 質問の削除時に、その質問のカテゴリーも同時に削除する
  has_one :question_category_map,
    dependent: :destroy
  has_one :category,
    through: :question_category_map

  # validates ########################

  # 「ユーザーID」のバリデーション
  validates :user_id,
    presence: true                   # 「質問」は必ず一人の「ユーザー」と紐付いている

  # 「画像」のバリデーション
  # validates :image,

  # 「質問のタイトル」のバリデーション
  validates :title,
    presence: true,                  # 入力必須。空白文字を許容しない。
    length: {                        # 文字数の制限
      maximum: 50,                   # 最大文字数
      allow_blank: true              # 「allow_blank: true」を付けることで、「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「質問の内容」のバリデーション
  validates :body,
    presence: true,                  # 入力必須。空白文字を許容しない。
    length: {                        # 文字数の制限
      maximum: 2000,                 # 最大文字数
      allow_blank: true              # 「allow_blank: true」を付けることで、「nil（空白文字）」の場合にはこの検証をスキップする
    }

end
