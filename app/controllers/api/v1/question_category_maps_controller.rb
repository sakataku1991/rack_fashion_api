module Api
  module V1
    class QuestionCategoryMapsController < ApplicationController

      # 「質問」の情報を設定
      before_action :set_question

      # # 「質問」⇄「カテゴリー」の新規登録
      # def create
      #   # 新しい「質問」⇄「カテゴリー」を作成
      #   @question_category_map = QuestionCategoryMap.new(question_category_map_params)
      #   # 送信された「質問」⇄「カテゴリー」が保存できる場合
      #   if @question_category_map.save
      #     render json: @question_category_map, status: :created
      #   # 送信された「質問」⇄「カテゴリー」が保存できない場合
      #   else
      #     # エラーメッセージを返す
      #     render json: @question_category_map.errors, status: :unprocessable_entity
      #   end
      # end

      # def create
      #   question = @question.category(@category)
      #   render json: category
      # end

      private

        # Strong Parameters の設定
        def question_category_map_params
          params.require(:question_category_map).permit(
            :user_id,
            :category_id
          )
        end

        def set_question
          @question = Question.find(params[:question_id])
          @category = Question.find(params[:category_id])
        end

    end
  end
end
