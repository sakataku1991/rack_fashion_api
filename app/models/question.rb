class Question < ApplicationRecord

  # 「質問」は必ずある一人の「ユーザー」に紐付いている（1対1）
  belongs_to :user

  # 「質問」を新しい順で取得
  default_scope -> { order(created_at: :desc) }

  # 「質問」の「画像」（CarrierWave）
  mount_uploader :image, QuestionImageUploader

  # 「質問」は必ずある一つの「性別」に紐付いている（1対1）
  # オプション: 質問の削除時に、その質問の性別も同時に削除する
  # has_one :question_sex_map,
  #   dependent: :destroy
  # has_one :sex,
  #   through: :question_sex_map
  belongs_to :sex

  # 「質問」は必ずある一つの「カテゴリー」に紐付いている（1対1）
  # オプション: 質問の削除時に、その質問のカテゴリーも同時に削除する
  # has_one :question_category_map,
  #   dependent: :destroy
  # has_one :category,
  #   through: :question_category_map
  belongs_to :category

  # 「質問」は必ずある一つの「色」に紐付いている（1対1）
  # オプション: 質問の削除時に、その質問の色も同時に削除する
  # has_one :question_color_map,
  #   dependent: :destroy
  # has_one :color,
  #   through: :question_color_map
  belongs_to :color

  # 「質問」には複数の「ハッシュタグ」を紐付けることができる（1対多）
  # オプション: 質問の削除時に、その質問のハッシュタグも同時に削除する
  has_many :question_hashtag_maps,
    dependent: :destroy
  has_many :hashtags,
    through: :question_hashtag_maps

  # 「質問」は必ずある一つの「公開状況」に紐付いている（1対1）
  # オプション: 質問の削除時に、その質問の公開状況も同時に削除する
  # has_one :question_post_status_map,
  #   dependent: :destroy
  # has_one :post_status,
  #   through: :question_post_status_map
  belongs_to :post_status

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
