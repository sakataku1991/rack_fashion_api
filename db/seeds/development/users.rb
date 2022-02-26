# 管理者権限を持つサンプルユーザー
User.create!(
  name: "admin",
  rack_id: "rack_id_admin",
  # sex: 1,
  email: "admin@example.com",
  password: "password",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

# ゲストユーザーのサンプルユーザー
User.create!(
  name: "guest",
  rack_id: "rack_id_guest",
  # sex: 1,
  email: "guest@example.com",
  password: "password",
  guest: true,
  activated: true,
  activated_at: Time.zone.now
)

# 一覧表示用の一般のサンプルユーザー（10人分）
10.times do |n|
  name = "user#{n}"
  rack_id = "rack_id#{n}"
  email = "#{name}@example.com"
  # find_by(rack_id: rack_id, email: email, activated: true)
  # オブジェクトが存在する => 取得
  # オブジェクトが存在しない => User.new(rack_id: rack_id, email: email, activated: true)
  user = User.find_or_initialize_by(
    rack_id: rack_id,
    email: email,
    # TODO 「会員登録」機能の実装時には「false」に設定し直すこと！
    activated: true,
    activated_at: Time.zone.now
  )

  if user.new_record?
    user.name = name
    # user.sex = 1
    user.password = "password"
    user.homepage = "https://www.rack-fashion.com/"
    user.save!
  end
end

puts "users = #{User.count}"
