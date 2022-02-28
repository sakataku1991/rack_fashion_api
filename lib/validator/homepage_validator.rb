class HomepageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # record:    レコード（Userひとつ分の属性・値の全部入り）
    # attribute: 属性（homepage:）
    # value:     値（自分のWebサイト（ホームページ）のURL）

    # 文字数の制限
    # 最大文字数
    max = 2000
    record.errors.add(attribute, :too_long, count: max) if value.length > max

    # 書式チェック
    # 半角英数字・ドット・アンダースコアのみ
    format = /\A#{URI::DEFAULT_PARSER.make_regexp(%w(http https))}\z/
    record.errors.add(attribute, :invalid_homepage) unless format =~ value

  end
end
