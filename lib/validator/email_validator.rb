class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # record:    レコード（Userひとつ分の属性・値の全部入り）
    # attribute: 属性（email:）
    # value:     値（a@a.a）

    # 文字数の制限
    # 最大文字数
    max = 255
    record.errors.add(attribute, :too_long, count: max) if value.length > max

    # 書式チェック
    # メールアドレスの形式
    format = /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/
    record.errors.add(attribute, :invalid) unless format =~ value

    # 一意性制約
    record.errors.add(attribute, :taken) if record.email_activated?

  end
end
