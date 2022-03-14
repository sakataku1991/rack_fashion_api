source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '1.3.2'
# Use Puma as the app server
# アプリケーションサーバー・Webサーバーとして働くやつ『Puma』
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# コンソールの出力結果を見やすく表示する
gem 'hirb', '~> 0.7.3'

# Hirbの文字列補正を行なう
gem 'hirb-unicode-steakknife', '~> 0.0.9'

# パスワードを暗号化する
gem 'bcrypt', '~> 3.1', '>= 3.1.16'

# JWT
# Doc: https://rubygems.org/gems/jwt
gem 'jwt', '~> 2.3'

# JSONファイルの加工
gem 'active_model_serializers', '~> 0.10.13'

# ファイル（画像など）のアップロード機能を追加してくれる
gem 'carrierwave', '~> 2.0'

# 画像の加工（リサイズ）を行なう
gem 'mini_magick', '~> 4.11'

# 画像の加工（リサイズ）を行なう。「MiniMagick」とセットでインストール。
gem 'image_processing', '~> 1.12', '>= 1.12.2'

# Webスクレイピングができるようになるライブラリ
gem 'nokogiri', '~> 1.13', '>= 1.13.3'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'capybara',                 '3.28.0'
  gem 'selenium-webdriver',       '3.142.4'
  gem 'webdrivers',               '4.1.2'
  gem 'rails-controller-testing', '1.0.4'
  # テスト結果に赤／緑の色を付ける
  gem 'minitest',                 '5.15.0'
  gem 'minitest-reporters', '~> 1.4', '>= 1.4.3'
  # ファイルの変更を監視し、自動的にテストを実行する
  gem 'guard',                    '2.16.2'
  gem 'guard-minitest',           '2.4.6'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
