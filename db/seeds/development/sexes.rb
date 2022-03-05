# 「性別」の初期設定データ
Sex.create!(
  [
    # 不明
    {
      name: "not known",
      code: 0,
      alias: "null"
    },
    # 男性
    {
      name: "male",
      code: 1,
      alias: "men"
    },
    # 女性
    {
      name: "female",
      code: 2,
      alias: "women"
    },
    # その他
    {
      name: "not applicable",
      code: 9,
      alias: "other"
    }
  ]
)

puts "sexes = #{Sex.count}"
