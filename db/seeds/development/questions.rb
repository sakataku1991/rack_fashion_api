# 「質問」のサンプル投稿（12件分）
question = Question.create!(
  [
    {
      user_id: 1,
      image: File.open("public/uploads/question/image/01/photo_post-question_dummy_01.jpg"),
      category_id: 1,
      title: "春のコート、何を買えばいいのか...",
      body: "こんにちは。今年はスプリングコートを買おうか迷っているのですが、みなさんはスプリングコートって何着くらい持っていますか？  また、今年買うならどういったタイプのコートがおすすめでしょうか？  色はベージュ系がいいです。",
      sex_id: 1,
      color_id: 5,
      post_status_id: 2
    },
    {
      user_id: 2,
      image: File.open("public/uploads/question/image/02/photo_post-question_dummy_02.jpg"),
      category_id: 2,
      title: "みなさんのお気に入りのバンドTを教えてください！",
      body: "最近古着屋さんでバンドTを買うのにハマっています。私のお気に入りはNirvanaの『In Utero』のジャケットがプリントされているものです。みなさんの自慢の一品も教えてください！",
      sex_id: 2,
      color_id: 2,
      post_status_id: 2
    },
    {
      user_id: 3,
      image: File.open("public/uploads/question/image/03/photo_post-question_dummy_03.jpg"),
      category_id: 11,
      title: "ジョギングをする時の格好で悩んでいます",
      body: "夏に向けて少し痩せたくて、これから毎日ジョギングをしようと考えています。ですがどういった格好をすればいいのかわからず...。ユニクロなど、なるべく安めで運動に向いた服でいいものがあれば紹介してくれると嬉しいです。",
      sex_id: 4,
      color_id: 15,
      post_status_id: 2
    },
    {
      user_id: 4,
      image: File.open("public/uploads/question/image/04/photo_post-question_dummy_04.jpg"),
      category_id: 11,
      title: "子供と公園で遊ぶ時の服装は何がいいでしょうか？",
      body: "タイトルの通りなのですが、息子と公園で遊ぶ時の服装で少し悩んでいます。ジャージというのもラフすぎる気がしますし...。みなさんはどうされていますか？",
      sex_id: 2,
      color_id: 15,
      post_status_id: 2
    },
    {
      user_id: 5,
      image: File.open("public/uploads/question/image/05/photo_post-question_dummy_05.jpg"),
      category_id: 5,
      title: "東京の原宿と高円寺の古着屋さんでオススメのお店はありますか？",
      body: "もうすぐ高校を卒業します。今度、友達とちょっとした旅行で東京に遊びに行く予定です。原宿と高円寺に行こうと考えているのですが、この2箇所で安くておしゃれな古着屋さんがあれば是非おすすめを教えてください！  よろしくお願いします。",
      sex_id: 3,
      color_id: 1,
      post_status_id: 2
    },
    {
      user_id: 6,
      image: File.open("public/uploads/question/image/06/photo_post-question_dummy_06.jpg"),
      category_id: 2,
      title: "HEUGNの22SSきてますね",
      body: "いや〜、今年のユーゲンの春夏最高ですよね！  みなさんは何か買われましたか？  自分はバイト代を貯めてグレーのニットベストを買います！",
      sex_id: 2,
      color_id: 3,
      post_status_id: 2
    },
    {
      user_id: 7,
      image: File.open("public/uploads/question/image/07/photo_post-question_dummy_07.jpg"),
      category_id: 10,
      title: "父の誕生日プレゼント",
      body: "来月父の誕生日があり、プレゼントに革のお財布をあげようと計画しています。男性の方にお聞きしたいのですが、どこのブランドのお財布を貰ったら嬉しいですか？  予算は3〜4万円で黒系のお財布がいいかな？と思っています。",
      sex_id: 3,
      color_id: 2,
      post_status_id: 2
    },
    {
      user_id: 8,
      image: File.open("public/uploads/question/image/08/photo_post-question_dummy_08.jpg"),
      category_id: 3,
      title: "サイズが大きめなデニムの穿き方",
      body: "こないだリーバイスのすごく太いデニムを購入しました。ただちょっと太すぎたのかお腹まわりがユルユルです。こういう場合ってベルトをすればなんとかなりますか？  何かうまくカバーできる方法があれば教えてください！",
      sex_id: 2,
      color_id: 7,
      post_status_id: 2
    },
    {
      user_id: 9,
      image: File.open("public/uploads/question/image/09/photo_post-question_dummy_09.jpg"),
      category_id: 3,
      title: "最近アクリルのカーディガンが流行ってますね",
      body: "あいみょんの影響かラコステのアクリルカーディガン流行ってますよね〜。ところでカーディガン着る場合って下は何を着れば合うと思いますか？  ジーンズ？  どんなコーデがいいでしょうか。",
      sex_id: 3,
      color_id: 6,
      post_status_id: 2
    },
    {
      user_id: 10,
      image: File.open("public/uploads/question/image/10/photo_post-question_dummy_10.jpg"),
      category_id: 6,
      title: "なんだかアディダスのスニーカーが気になっています",
      body: "はじめまして。雑誌を見たりしてアディダスのスニーカーに興味を持ったのですが、まずは何か定番のものを買いたいな〜と思っています。アディダスでこれは必ず持っておけ！みたいな定番スニーカーって何がありますか？",
      sex_id: 1,
      color_id: 1,
      post_status_id: 2
    },
    {
      user_id: 11,
      image: File.open("public/uploads/question/image/11/photo_post-question_dummy_11.jpg"),
      category_id: 10,
      title: "ちょっと質の良いハンガーを買いたいです",
      body: "これまでずっと100均のハンガーを使ってきたのですが、もう少し丈夫なハンガーに買い替えようと考えています。無印良品のものって品質はどうなんでしょうか？  使っている方がいらっしゃいましたら使用感など教えていただけるとありがたいです。",
      sex_id: 3,
      color_id: 15,
      post_status_id: 2
    },
    {
      user_id: 12,
      image: File.open("public/uploads/question/image/12/photo_post-question_dummy_12.jpg"),
      category_id: 11,
      title: "あこがれのヴィンテージ古着について語りましょう",
      body: "もういい年なんですが今年に入ってから古着に目覚めてしまいました。古着好きの方でこれはいつか絶対にほしい！みたいなヴィンテージアイテムって何かありますか？  私は50〜60年代頃のシープスキンのレザージャケットを探しています。",
      sex_id: 2,
      color_id: 4,
      post_status_id: 2
    }
  ]
)

puts "questions = #{Question.count}"
