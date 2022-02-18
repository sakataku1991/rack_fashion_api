class RackIdValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # record:    レコード（Userひとつ分の属性・値の全部入り）
    # attribute: 属性（rack_id:）
    # value:     値（rack-chan）

    # 文字数の制限
    # 最小文字数
    min = 3
    record.errors.add(attribute, :too_short, count: min) if value.length < min
    # 最大文字数
    max = 16
    record.errors.add(attribute, :too_long, count: max) if value.length > max

    # 書式チェック
    # 半角英数字・アンダースコアのみ
    format = /\A[a-zA-Z0-9_]+\z/
    record.errors.add(attribute, :invalid_rack_id) unless format =~ value

    # 一意性制約
    record.errors.add(attribute, :taken) if record.rack_id_activated?

  end
end
