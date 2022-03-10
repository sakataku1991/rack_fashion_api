module Api
  module V1
    class QuestionsController < ApplicationController

      # 有効なアクセストークンが投げられない（＝ログインしていない）限り、リソースにアクセスできないようになるアクション
      # before_action :authenticate_active_user, only: %i[new create edit update destroy]

      # 画像のURLを取得するメソッド
      include Rails.application.routes.url_helpers

      # 「質問」の一覧の取得
      def index
        # 「質問」の情報
        @question = Question.all.includes(
          :user,
          :sex,
          :category,
          :color,
          :hashtags,
          :post_status
        )
        render json:
          @question.as_json(
            include: %i[
              user
              sex
              category
              color
              hashtags
              post_status
            ]
          )
      end

      # 「質問」の一覧の取得（ページネーションの実装に必要）
      def show
      end

      # 「質問」の新規登録
      def new
        @question = Question.new
        @question.build_category
      end

      # 「質問」の新規登録
      def create
        # 新しい質問を作成
        @question = Question.new(question_params)
        @category = @question.build_question_category_map(question_category_map_params)
        # 送信された質問が保存できる場合
        if @question.save
          render json: @question, status: :created
        # 送信された質問が保存できない場合
        else
          # エラーメッセージを返す
          render json: @question.errors, status: :unprocessable_entity
        end
      end

      # このclass内でのみ呼び出し可能なメソッド
      # この「questions_controller.rb」内でのみ使える
      private

        # Strong Parameters の設定
        def question_params
          params.require(:question).permit(
            :user_id,
            :image,
            :title,
            :body,
            :sex,
            :category_id,
            :color,
            :hashtag,
            :post_status
          )
        end

        def question_category_map_params
          params.require(:question_category_map).permit(
            :question_id,
            :category_id
          )
        end

            # { hashtag_ids: [] }).merge(user_id: current_user.id)

    end
  end
end
