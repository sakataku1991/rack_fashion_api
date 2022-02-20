class ApplicationController < ActionController::API

  # Cookieを扱う
  include ActionController::Cookies
  # 認可を行なう
  include UserAuthenticateService

end
