Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # 「ユーザー」「users_controller.rb」
      resources :users, only:[:index]

      # 「AuthToken」「auth_token_controller.rb」
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end

    end
  end
end
