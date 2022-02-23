# 不明
Sex.create!(
  sex: "not known",
  code: "0"
)

# 男性
Sex.create!(
  sex: "male",
  code: "1"
)

# 女性
Sex.create!(
  sex: "female",
  code: "2"
)

# その他
Sex.create!(
  sex: "not applicable",
  code: "9"
)

puts "sexes = #{Sex.count}"
