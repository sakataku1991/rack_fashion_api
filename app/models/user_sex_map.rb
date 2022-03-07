class UserSexMap < ApplicationRecord

  # 一つの「user_sex_maps」は、ある一人の「ユーザー」と
  belongs_to :user

  # ある一つの「性別」との関係性を示している
  belongs_to :sex

  # validates ########################

  validates :user_id,
    presence: true

  validates :sex_id,
    presence: true

end
