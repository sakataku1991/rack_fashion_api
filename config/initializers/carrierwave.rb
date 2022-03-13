CarrierWave.configure do |config|

  if Rails.env.production?
    # フロント側でAPIに保存されている画像のURLが取得できるようになる設定
    config.asset_host = 'https://api.rack-fashion.com'
  else
    # フロント側でAPIに保存されている画像のURLが取得できるようになる設定
    config.asset_host = 'http://localhost:3000'
  end

end
