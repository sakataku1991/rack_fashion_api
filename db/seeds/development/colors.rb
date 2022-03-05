# 「色」の初期設定データ
Color.create!(
  [
    # ホワイト
    {
      name: "white",
      code: 1
    },
    # ブラック
    {
      name: "black",
      code: 2
    },
    # グレー
    {
      name: "gray",
      code: 3
    },
    # ブラウン
    {
      name: "brown",
      code: 4
    },
    # ベージュ
    {
      name: "beige",
      code: 5
    },
    # グリーン
    {
      name: "green",
      code: 6
    },
    # ブルー
    {
      name: "blue",
      code: 7
    },
    # パープル
    {
      name: "purple",
      code: 8
    },
    # イエロー
    {
      name: "yellow",
      code: 9
    },
    # ピンク
    {
      name: "pink",
      code: 10
    },
    # レッド
    {
      name: "red",
      code: 11
    },
    # オレンジ
    {
      name: "orange",
      code: 12
    },
    # シルバー
    {
      name: "silver",
      code: 13
    },
    # ゴールド
    {
      name: "gold",
      code: 14
    },
    # その他
    {
      name: "others",
      code: 15
    }
  ]
)

puts "colors = #{Color.count}"
