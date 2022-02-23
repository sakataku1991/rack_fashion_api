class AccountActivationsController < ApplicationController

  # ユーザーのセッション管理機能の呼び出し
  include UserSessionizeService

  # 404エラーが発生した場合にヘッダーのみを返す
  rescue_from UserAuth.not_found_exception_class, with: :not_found
  # refresh_tokenのInvalidJitErrorが発生した場合はカスタムエラーを返す
  rescue_from JWT::InvalidJtiError, with: :invalid_jti

  # userのログイン情報を確認する
  before_action :authenticate, only: [:create]
  # 処理前にsessionを削除する
  before_action :delete_session, only: [:create]
  # session_userを取得、存在しない場合は401を返す
  before_action :sessionize_user, only: [:refresh, :destroy]

  def edit
    # 確認URLのパラメーター内にあるメールアドレスからユーザーを検索
    user = User.find_by(email: params[:email])
    # まだアクティブになっておらず、トークンとダイジェストが一致する場合は
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # ユーザーの「activated」を「true」に変更し、
      user.update_attribute(:activated, true)
      # 「activated_at」を「確認URLに接続した時間」に更新
      user.update_attribute(:activated_at, Time.zone.now)
      # そしてユーザーをログイン状態にし
      @user = login_user
      set_refresh_token_to_cookie
      render json: login_response
      # flash[:success] = "Account activated!"
      # そのユーザーのマイページを表示する
      # redirect_to '/mypage'
    # すでにアクティブなユーザー、もしくは、トークンとダイジェストが一致しなかった場合は
    else
      # flash[:danger] = "Invalid activation link"
      # トップページへリダイレクトする
      # redirect_to '/'
    end
  end

  # リフレッシュ
  def refresh
    @user = session_user
    set_refresh_token_to_cookie
    render json: login_response
  end

  private

    # params[:email]からアクティブなユーザーを返す
    def login_user
      @_login_user ||= User.find_by(email: params[:email])
    end

    # refresh_tokenをcookieにセットする
    def set_refresh_token_to_cookie
      cookies[session_key] = {
        value: refresh_token,
        expires: refresh_token_expiration,
        secure: Rails.env.production?,
        http_only: true
      }
    end

    # ログイン時のデフォルトレスポンス
    def login_response
      {
        token: access_token,
        expires: access_token_expiration,
        user: @user.response_json(sub: access_token_subject)
      }
    end

    # リフレッシュトークンのインスタンス生成
    def encode_refresh_token
      @_encode_refresh_token ||= @user.encode_refresh_token
    end

    # リフレッシュトークン
    def refresh_token
      encode_refresh_token.token
    end

    # リフレッシュトークンの有効期限
    def refresh_token_expiration
      Time.at(encode_refresh_token.payload[:exp])
    end

    # アクセストークンのインスタンス生成
    def encode_access_token
      @_encode_access_token ||= @user.encode_access_token
    end

    # アクセストークン
    def access_token
      encode_access_token.token
    end

    # アクセストークンの有効期限
    def access_token_expiration
      encode_access_token.payload[:exp]
    end

    # アクセストークンのsubjectクレーム
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
