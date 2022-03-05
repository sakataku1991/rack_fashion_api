class UserSexMap < ApplicationRecord

  # 「user_sex_maps」は複数の「ユーザー」と紐付いている
  belongs_to :user

  # 「user_sex_maps」は複数の「性別」と紐付いている
  belongs_to :sex

  # validates ########################

  validates :user_id,
    presence: true

  validates :sex_id,
    presence: true

end
