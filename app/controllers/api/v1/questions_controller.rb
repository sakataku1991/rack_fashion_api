module Api
  module V1
    class QuestionsController < ApplicationController

      # 有効なアクセストークンが投げられない（＝ログインしていない）限り、リソースにアクセスできないようになるアクション
      # before_action :authenticate_active_user, only: %i[new create edit update destroy]

      # 「質問」の一覧の取得
      def index
        # 「質問」の情報
        @question = Question.all.includes(
          :user,
          :sex,
          :category,
          :color
        )
        render json:
          @question.as_json(
            include: %i[
              user
              sex
              category
              color
            ]
          )
      end

      # 「質問」の一覧の取得（ページネーションの実装に必要）
      def show
      end

      # このclass内でのみ呼び出し可能なメソッド
      # この「questions_controller.rb」内でのみ使える
      private

        # Strong Parameters の設定
        def question_params
          params.require(:question).permit(
            :id,
            :user_id,
            :image,
            :title,
            :body,
            :created_at
          )
        end

    end
  end
end
