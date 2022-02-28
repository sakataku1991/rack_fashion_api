class Sex < ApplicationRecord

  # 「性別」が紐付いている「ユーザー」（1対多）
  has_many :user_sex_map, dependent: :destroy, foreign_key: 'sex_id'
  has_many :user, through: :user_sex_map

end
