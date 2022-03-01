# 「RACK ID」のカスタムバリデーションの呼び出し
require "validator/rack_id_validator"

# 「メールアドレス」のカスタムバリデーションの呼び出し
require "validator/email_validator"

# 「Instagramのユーザーネーム」のカスタムバリデーションの呼び出し
require "validator/instagram_validator"

# 「Twitterのユーザー名」のカスタムバリデーションの呼び出し
require "validator/twitter_validator"

# 「自分のWebサイト（ホームページ）」のカスタムバリデーションの呼び出し
require "validator/homepage_validator"

class User < ApplicationRecord

  # アクセサーの作成
  attr_accessor :activation_token

  # Token生成モジュール
  include TokenGenerateService

  # ファイルのURLを取得するメソッド（画像など）
  include Rails.application.routes.url_helpers

  # 小文字化の処理
  before_validation :downcase_rack_id
  before_validation :downcase_email
  before_validation :downcase_instagram
  before_validation :downcase_twitter

  # 新しいユーザーの作成時に「activation_digest」を同時に生成
  before_create :create_activation_digest

  # 「ユーザー」に紐付いている「性別」（1対1）
  has_many :user_sex_maps, dependent: :destroy, foreign_key: 'user_id'
  has_many :sexes, through: :user_sex_maps

  # 「has_secure_password」はgemのbcryptの機能
  # 新規会員登録時に動作するバリデーション
  # 1. passwordを暗号化する
  # 2. password_digest => password
  # 3. password_confirmation => パスワードの一致確認
  # 4. 一致のバリデーション追加
  # 5. authenticate()
  # 6. 最大文字数 72文字まで
  # 7. User.create() => ユーザー作成時（新規会員登録時）には必ず加えたい、「入力必須」のバリデーション、 Uesr.update() => ×
  has_secure_password

  # validates ########################

  # 「ユーザー名」のバリデーション
  validates :name,
    presence: true,                  # 入力必須。空白文字を許容しない。
    length: {                        # 文字数の制限
      maximum: 30,                   # 最大文字数
      allow_blank: true              # 「allow_blank: true」を付けることで、「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「RACK ID」のバリデーション
  validates :rack_id,
    presence: true,                  # 入力必須
    rack_id: {                         # カスタムバリデーションの呼び出し
      allow_blank: true              # 「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「メールアドレス」のバリデーション
  validates :email,
    presence: true,                  # 入力必須。空白文字を許容しない。
    email: {                         # カスタムバリデーションの呼び出し
      allow_blank: true              # 「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「パスワード」のバリデーション
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  # VALID_PASSWORD_REGEX : 半角英数字・アンダースコア・ハイフンのみ
  # \A     => 文字列の先頭にマッチ
  # [\w\-] => a-z, A-Z, 0-9, _, - <= これらと同等
  # +      => 1文字以上繰り返されている文字列かどうか
  # \z     => 文字列の末尾にマッチ
  validates :password,
    presence: true,                  # 入力必須。空白文字を許容しない。
    length: {                        # 文字数の制限
      minimum: 8,                    # 最小文字数
      allow_blank: true              # 「nil（空白文字）」の場合にはこの検証をスキップする
    },
    format: {                        # 書式チェック
      with: VALID_PASSWORD_REGEX,    # 書式チェックに使う正規表現
      message: :invalid_password,    #「ja.yml」に設定したオリジナルのバリデーションメッセージを呼び出す
      allow_blank: true              # 「nil（空白文字）」の場合にはこの検証をスキップする
    },
    allow_nil: true                  # 「nil（空白文字）」の場合にはこの検証をスキップする（「presence: true」とワンセット。パスワードが空欄でも問題ない時（ユーザー名を更新するだけの時など）に、このバリデーションを機能させない。）※ただしユーザーの新規会員登録時だけはbcryptのおかげでこのallow_nilを無視してちゃんと入力必須のバリデーションが効いてくれる。

  # 「プロフィール」のバリデーション
  validates :profile,
    length: {                        # 文字数の制限
      maximum: 160,                  # 最大文字数
      allow_blank: true              # 「allow_blank: true」を付けることで、「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「Instagramのユーザーネーム」のバリデーション
  validates :instagram,
    instagram: {                     # カスタムバリデーションの呼び出し
      allow_blank: true              # 「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「Twitterのユーザー名」のバリデーション
  validates :twitter,
    twitter: {                       # カスタムバリデーションの呼び出し
      allow_blank: true              # 「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「自分のWebサイト（ホームページ）」のバリデーション
  validates :homepage,
    homepage: {                      # カスタムバリデーションの呼び出し
      allow_blank: true              # 「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「アバター（ユーザーのアイコン画像）」
  has_one_attached :avatar

  def avatar_image_url
    # アバターの画像のURLを取得する
    avatar.attached? ? url_for(avatar) : nil
  end


  # methods ########################

  # class method ============
  class << self
    # rack_idからアクティブなユーザーを返す
    def find_by_activated_rack_id(rack_id)
    find_by(rack_id: rack_id, activated: true)
    end
  end
  # class method end ============

  # 自分以外の同じrack_idのアクティブなユーザーがいる場合にtrueを返す
  def rack_id_activated?
    users = User.where.not(id: id)
    users.find_by_activated_rack_id(rack_id).present?
  end

  # class method  ============
  class << self
    # emailからアクティブなユーザーを返す
    def find_by_activated_email(email)
    find_by(email: email, activated: true)
    end
  end
  # class method end ============

  # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_by_activated_email(email).present?
  end

  # 「リフレッシュトークン」のJWT IDを記憶する
  def remember(jti)
    update!(refresh_jti: jti)
  end

  # 「リフレッシュトークン」のJWT IDを削除する
  def forget
    update!(refresh_jti: nil)
  end

  # 共通のJSONレスポンスを返すメソッド
  def response_json(payload = {})
    as_json(only: [
      :id,
      :name,
      :rack_id,
      :sex,
      :sex_id,
      :gender,
      :code,
      :email,
      :profile,
      :instagram,
      :twitter,
      :homepage,
      :avatar,
      :avatar_image_url,
      :created_at, # TODO 後で消す！
      :activated # TODO 後で消す！
    ]).merge(payload).with_indifferent_access
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

    # 「RACK ID」の小文字化
    def downcase_rack_id
      self.rack_id.downcase! if rack_id
    end

    # 「メールアドレス」の小文字化
    def downcase_email
      self.email.downcase! if email
    end

    # 「Instagramのユーザーネーム」の小文字化
    def downcase_instagram
      self.instagram.downcase! if instagram
    end

    # 「Twitterのユーザー名」の小文字化
    def downcase_twitter
      self.twitter.downcase! if twitter
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
