# 管理者権限を持つサンプルユーザー
UserSexMap.create!(
  user_id: 1,
  sex_id: 1
)

# ゲストユーザーのサンプルユーザー
UserSexMap.create!(
  user_id: 2,
  sex_id: 1
)

# 一覧表示用の一般のサンプルユーザー（10人分）
10.times do |n|
  UserSexMap.create!(
    user_id: n+3,
    sex_id: 1
  )
end

puts "userSexMap = #{UserSexMap.count}"
