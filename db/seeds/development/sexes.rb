# 「性別」の初期設定データ
Sex.create!(
  [
    # 不明
    {
      gender: "not known",
      code: 0
    },
    # 男性
    {
      gender: "male",
      code: 1
    },
    # 女性
    {
      gender: "female",
      code: 2
    },
    # その他
    {
      gender: "not applicable",
      code: 9
    }
  ]
)

puts "sexes = #{Sex.count}"
