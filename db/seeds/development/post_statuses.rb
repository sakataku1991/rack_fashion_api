# 「公開状況」の初期設定データ
PostStatus.create!(
  [
    # 未保存
    {
      name: "unsaved",
      code: 0
    },
    # 公開
    {
      name: "publish",
      code: 1
    },
    # 下書き
    {
      name: "draft",
      code: 2
    },
    # 非公開
    {
      name: "private",
      code: 3
    },
    # 削除
    {
      name: "delete",
      code: 4
    }
  ]
)

puts "postStatuses = #{PostStatus.count}"
