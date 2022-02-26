Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # 「AuthToken」「auth_token_controller.rb」
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

      get '/signup', to: 'users#create'
      get '/mypage', to: 'mypage#show'

      # 「ユーザー」「users_controller.rb」
      resources :users, only: %i[index show new create edit update destroy]

      # 「質問」「questions_controller.rb」
      resources :questions, only: %i[index show new create edit update destroy]

      # 「性別」「user_sex_maps_controller.rb」
      resources :sexs, only: %i[create update]

      # 「ユーザー」の「性別」
      resources :user_sex_maps, only: %i[create update destroy]

    end
  end

  # ユーザーの会員登録の「メール認証」「account_activations_controller.rb」
  resources :account_activations, only: [:edit]
end
