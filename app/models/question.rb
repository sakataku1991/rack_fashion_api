class Question < ApplicationRecord

  # 「question」は必ずある一人の「ユーザー」と紐付いている
  belongs_to :user

end
