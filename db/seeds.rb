table_names = %w(
  users
  sexes
  questions
  post_statuses
  categories
  colors
  hashtags
  user_sex_maps
  question_sex_maps
  question_post_status_maps
  question_category_maps
  question_color_maps
  question_hashtag_maps
)

table_names.each do |table_name|
  path = Rails.root.join("db/seeds/#{Rails.env}/#{table_name}.rb")

  # ファイルが存在しない場合はdevelopmentディレクトリを読み込む
  path = path.sub(Rails.env, "development") unless File.exist?(path)

  puts "#{table_name}..."
  require path
end
