# 不明
Sex.create!(
  gender: "not known",
  code: 0
)

# 男性
Sex.create!(
  gender: "male",
  code: 1
)

# 女性
Sex.create!(
  gender: "female",
  code: 2
)

# その他
Sex.create!(
  gender: "not applicable",
  code: 9
)

puts "sexes = #{Sex.count}"
