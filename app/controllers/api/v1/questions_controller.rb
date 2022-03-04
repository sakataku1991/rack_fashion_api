module Api
  module V1
    class QuestionsController < ApplicationController

      # 有効なアクセストークンが投げられない限り、リソースにアクセスできないようになるアクション
      # before_action :authenticate_active_user

      # 「質問」の一覧の取得
      def index
        # 「質問」の情報
        @question = Question.all
        render json:
          @question.as_json(
            only: [
              :id,
              :user_id,
              :title,
              :body,
              :created_at,
              :updated_at
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
            :body
          )
        end

    end
  end
end
