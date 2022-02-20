Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # 「AuthToken」「auth_token_controller.rb」
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      # 「ユーザー」「users_controller.rb」
      resources :users, only:[:index]

      # 「質問」「questions_controller.rb」
      resources :questions, only:[:index]

    end
  end
end
