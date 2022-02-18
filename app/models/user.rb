class User < ApplicationRecord

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

  # validates ========================

  # 「ユーザー名」のバリデーション
  validates :name,
    presence: true,                  # 入力必須。空白文字を許容しない。
    length: {                        # 文字数の制限
      maximum: 30,                   # 最大文字数
      allow_blank: true              # 「allow_blank: true」を付けることで、「nil（空白文字）」の場合にはこの検証をスキップする
    }

  # 「RACK ID」のバリデーション
  VALID_RACK_ID_REGEX = /\A[a-zA-Z0-9_]+\z/
  # VALID_RACK_ID_REGEX : 半角英数字・アンダーバーのみ
  validates :rack_id,
    presence: true,                  # 入力必須
    length: {                        # 文字数の制限
      minimum: 3,                    # 最小文字数
      maximum: 16,                   # 最大文字数
      allow_blank: true              # 「nil（空白文字）」の場合にはこの検証をスキップする
    },
    format: {                        # 書式チェック
      with: VALID_RACK_ID_REGEX,     # 書式チェックに使う正規表現
      message: :invalid_rack_id,     #「ja.yml」に設定したオリジナルのバリデーションメッセージを呼び出す
      allow_blank: true              # nil, 空白文字の場合に検証をスキップ
    }

  # 「パスワード」のバリデーション
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  # VALID_PASSWORD_REGEX : 半角英数字・アンダーバー・ハイフンのみ
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

end
