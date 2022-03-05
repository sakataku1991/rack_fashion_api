module Api
  module V1
    class UsersController < ApplicationController

      before_action :set_user, only: [
        :update
      ]

      # ユーザーのセッション管理機能の呼び出し
      # Dir: /api/app/services/user_sessionize_service.rb
      include UserSessionizeService

      # 「rescue_from」
      # → このclassで例外が発生した場合に実行するメソッドのこと
      # → エラー処理のメソッドを別ファイルで用意し、必要なコントローラーで適宜呼び出して使う

      # 404エラーが発生した場合にヘッダーのみを返す
      # Dir: /api/config/initializers/user_auth.rb
      rescue_from UserAuth.not_found_exception_class, with: :not_found

      # 「リフレッシュトークン」のInvalidJitErrorが発生した場合はカスタムエラーを返す
      rescue_from JWT::InvalidJtiError, with: :invalid_jti

      # 「before_action」
      # → このclass内の各アクションが実行されるよりも前に実行されるメソッドのこと

      # 処理前にセッション（Cookie）を削除する
      # /api/app/services/user_sessionize_service.rb
      before_action :delete_session, only: [:create]

      # session_userを取得する、存在しない場合は401を返す
      # /api/app/services/user_sessionize_service.rb
      before_action :sessionize_user, only: [:refresh, :destroy]

      # 有効なアクセストークンが投げられない限り、リソースにアクセスできないようになるアクション
      # ログイン済みのユーザーにしかアクセスさせたくないリソースには以下のメソッドを使用すること！
      # before_action :authenticate_active_user

      # 「ユーザー」の一覧の取得
      def index
        # 「ユーザー」の情報
        @user = User.all
        render json:
          @user.as_json(
            only: %i[
              id
              name
              rack_id
              sex
              sex_id
              gender
              code
              email
              profile
              instagram
              twitter
              homepage
              avatar
              avatar_image_url
              created_at
              activated
            ]
          ), methods: [:avatar_image_url]

          # # 「性別」の情報
          # @sex_list=Sex.all
          # render json:
          # @sex.as_json(
          #   only: [
          #     :code
          #   ]
          # )
      end

      # # 「ユーザー」の一覧の取得
      # def index
      #   # 「ユーザー」の情報
      #   @user = User.all
      #   render json:
      #     @user.as_json(
      #       only: %i[
      #         id
      #         name
      #         rack_id
      #         sex
      #         sex_id
      #         gender
      #         code
      #         email
      #         profile
      #         instagram
      #         twitter
      #         homepage
      #         avatar
      #         avatar_image_url
      #         created_at
      #         activated
      #       ]
      #     ), methods: [:avatar_image_url]

      #     # # 「性別」の情報
      #     # @sex_list=Sex.all
      #     # render json:
      #     # @sex.as_json(
      #     #   only: [
      #     #     :code
      #     #   ]
      #     # )
      # end

      # 「ユーザー」の新規登録
      def create
        # 新しいユーザーを作成
        @user = User.new(user_params)
        # 送信されたユーザーが保存できる場合
        if @user.save
          # 「会員登録」フォームから送られてきたユーザーデータを保存
          # render json: @user, status: :created
          # UserMailer.account_activation(@user).deliver_now
          # 「activated」を「true」にし
          @user.update_attribute(:activated, true)
          # 「activated_at」に登録の時刻を記録
          @user.update_attribute(:activated_at, Time.zone.now)
          # 続けてユーザーをログインさせる
          login
        # 送信されたユーザーが保存できない場合
        else
          # エラーメッセージを返す
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # 「ユーザー」の更新
      def update
        sex_list=params[:user][:code].split(',')
        if @user.update(user_params.except(:rack_id))
          @post.save_sex(sex_list)
          render json: @user, methods: [:avatar_image_url]
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # 「ユーザー」の削除
      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: user
        else
          render json: { status: 400 }
        end
      end

      # このclass内でのみ呼び出し可能なメソッド
      # この「users_controller.rb」内でのみ使える
      private

        # Strong Parameters の設定
        def user_params
          params.require(:user).permit(
            :id,
            :name,
            :rack_id,
            :sex,
            :sex_id,
            :gender,
            :code,
            :email,
            :password,
            :profile,
            :instagram,
            :twitter,
            :homepage,
            :avatar,
            :avatar_image_url
          )
        end

        def set_user
          # @user = User.find(user_params[:rack_id])
          @user = User.find(params[:id])
        end

        # ログイン
        def login
          # 「user」に「login_user」を代入
          # （ログインユーザーの認証）
          @user = login_user
          # 「リフレッシュトークン」を「Cookie」にセットする
          set_refresh_token_to_cookie
          # ログイン時のデフォルトレスポンスを返す
          render json: login_response
        end

        # params[:email]を元にアクティブなユーザーを返す
        def login_user
          # データベースに「メールアドレス」があり、かつ、「activated: true」なら、それらの値を「login_user」に代入する
          @_login_user ||= User.find_by_activated_email(user_params[:email])
        end

        # 「リフレッシュトークン」を「Cookie」にセットする
        def set_refresh_token_to_cookie
          cookies[session_key] = {
            value: refresh_token,
            expires: refresh_token_expiration,
            secure: Rails.env.production?,
            http_only: true
          }
        end

        # ログイン時のデフォルトレスポンス
        # （「アクセストークン」の発行）
        def login_response
          {
            token: access_token,
            expires: access_token_expiration,
            user: @user.response_json(sub: access_token_subject)
          }
        end

        # 「リフレッシュトークン」のインスタンス生成
        def encode_refresh_token
          # データベースにエンコードされた「リフレッシュトークン」がすにあれば、その「リフレッシュトークン」を「encode_refresh_token」に代入する
          # 「なければ、ない」ということ？
          @_encode_refresh_token ||= @user.encode_refresh_token
        end

        # 「リフレッシュトークン」
        def refresh_token
          encode_refresh_token.token
        end

        # 「リフレッシュトークン」の有効期限
        def refresh_token_expiration
          Time.at(encode_refresh_token.payload[:exp])
        end

        # 「アクセストークン」のインスタンス生成
        def encode_access_token
          @_encode_access_token ||= @user.encode_access_token
        end

        # 「アクセストークン」
        def access_token
          encode_access_token.token
        end

        # 「アクセストークン」の有効期限
        def access_token_expiration
          encode_access_token.payload[:exp]
        end

        # 「アクセストークン」のsubjectクレーム
        def access_token_subject
          encode_access_token.payload[:sub]
        end

        # 404ヘッダーのみの返却を行う
        # Doc: https://gist.github.com/mlanett/a31c340b132ddefa9cca
        def not_found
          head(:not_found)
        end

        # decode jti != user.refresh_jti のエラー処理
        def invalid_jti
          msg = "Invalid jti for refresh token"
          render status: 401, json: { status: 401, error: msg }
        end

    end
  end
end
