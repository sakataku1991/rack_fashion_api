class TwitterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # record:    レコード（Userひとつ分の属性・値の全部入り）
    # attribute: 属性（twitter:）
    # value:     値（Twitterで使用している実際のユーザー名）

    # 文字数の制限
    # 最大文字数
    max = 15
    record.errors.add(attribute, :too_long, count: max) if value.length > max

    # 書式チェック
    # 半角英数字・ドット・アンダースコアのみ
    format = /\A[a-zA-Z0-9._]+\z/
    record.errors.add(attribute, :invalid_twitter) unless format =~ value

  end
end
