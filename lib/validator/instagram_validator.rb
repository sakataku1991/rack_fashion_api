class InstagramValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # record:    レコード（Userひとつ分の属性・値の全部入り）
    # attribute: 属性（instagram:）
    # value:     値（Instagramで使用している実際のユーザーネーム）

    # 文字数の制限
    # 最大文字数
    max = 30
    record.errors.add(attribute, :too_long, count: max) if value.length > max

    # 書式チェック
    # 半角英数字・アンダースコアのみ
    format = /\A[a-zA-Z0-9_]+\z/
    record.errors.add(attribute, :invalid_instagram) unless format =~ value

  end
end
