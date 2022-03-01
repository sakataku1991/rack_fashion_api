class Sex < ApplicationRecord

  # 「性別」が紐付いている「ユーザー」（1対多）
  has_many :user_sex_maps, dependent: :destroy, foreign_key: 'sex_id'
  has_many :users, through: :user_sex_maps

  validates :code, presence: true, uniqueness: true

  def save_sex(sent_sexes)
    # 「性別」が存在していれば、「性別」の名前を配列として全て取得
    current_sexes = self.sexes.pluck(:code) unless self.sexes.nil?
    # 現在取得した「性別」から送られてきた「性別」を除いてoldsexとする
    old_sexes = current_sexes - sent_sexes
    # 送信されてきた「性別」から現在存在する「性別」を除いた「性別」をnewとする
    new_sexes = sent_sexes - current_sexes

    # 古い「性別」を消す
    old_sexes.each do |old|
      self.sexes.delete Sex.find_by(code: old)
    end

    # 新しい「性別」を保存
    new_sexes.each do |new|
      new_user_sex = Sex.find_or_create_by(code: new)
      self.sexes << new_user_sex
    end
  end

end
