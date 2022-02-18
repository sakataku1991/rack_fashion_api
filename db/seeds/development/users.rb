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
    activated: true
  )

  if user.new_record?
    user.name = name
    user.password = "password"
    user.save!
  end
end

puts "users = #{User.count}"
