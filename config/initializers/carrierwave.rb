CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    # アクセスキー
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    #aws_access_key_id:     "aaaa",
    # シークレットキー
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    #aws_secret_access_key: "bbbb",
    # Tokyo
    region:                'ap-northeast-1'
  }

  # 公開・非公開の切り替え
  #config.fog_public     = true
  # キャッシュの保存期間
  #config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }

  # キャッシュをS3に保存
  #config.cache_storage = :fog

  # 環境ごとにS3のバケットを指定
  case Rails.env
    when 'production'
      config.fog_directory = 'ranq-media-image-store'
      #config.asset_host = 'https://ranq-media-image-store.s3-ap-northeast-1.amazonaws.com'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/ranq-media-image-store'

    when 'development'
      config.fog_directory = 'dev-ranq-media-image-store'
      #config.asset_host = 'https://dev-ranq-media-image-store.s3-ap-northeast-1.amazonaws.com'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dev-ranq-media-image-store'

    when 'test'
      config.fog_directory = 'dev-ranq-media-image-store'
      #config.asset_host = 'https://dev-ranq-media-image-store.s3-ap-northeast-1.amazonaws.com'
  end
end

# 日本語ファイル名の設定
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
