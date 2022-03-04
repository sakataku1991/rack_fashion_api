class Question < ApplicationRecord

  # 「質問」は必ずある一人の「ユーザー」に紐付いている（1対1）
  belongs_to :user

  # 「質問」を新しい順で取得
  default_scope -> { order(created_at: :desc) }

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
