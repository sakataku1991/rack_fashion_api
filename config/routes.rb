Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # 「ユーザー」「users_controller.rb」
      resources :users, only:[:index]

    end
  end
end
