# 「カテゴリー」の初期設定データ
Category.create!(
  [
    # アウター
    {
      name: "jackets",
      code: 1
    },
    # トップス
    {
      name: "tops",
      code: 2
    },
    # パンツ
    {
      name: "bottoms",
      code: 3
    },
    # スカート
    {
      name: "skirts",
      code: 4
    },
    # ワンピース
    {
      name: "dresses",
      code: 5
    },
    # 靴
    {
      name: "shoes",
      code: 6
    },
    # バッグ
    {
      name: "bags",
      code: 7
    },
    # 帽子
    {
      name: "hats",
      code: 8
    },
    # アクセサリー
    {
      name: "accessories",
      code: 9
    },
    # 小物・雑貨
    {
      name: "goods",
      code: 10
    },
    # その他
    {
      name: "others",
      code: 11
    }
  ]
)

puts "categories = #{Category.count}"
