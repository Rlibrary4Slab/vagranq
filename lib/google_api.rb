require 'google/api_client'
require 'date'

class GoogleApi
  API_VERSION = 'v3'
  CACHED_API_FILE = "#{Rails.root}/certificate/analytics-#{API_VERSION}.cache"
  SERVICE_ACCOUNT_EMAIL = "ranq-1365@appspot.gserviceaccount.com"
  KEY_FILE = "#{Rails.root}/certificate/RanQ-dcd0dc9452e3.p12" #適宜変更
  KEY_SECRET = "notasecret" #適宜変更
  VIEW_ID = "125219829" #適宜変更

  def initialize
    @client = Google::APIClient.new(
      application_name: 'ranqforrepo', #適宜変更
      application_version: '1.0.0' #適宜変更
      )
  end

  def api
    analytics = nil
    if File.exists? CACHED_API_FILE
      File.open(CACHED_API_FILE) do |file|
        analytics = Marshal.load(file)
      end
    else
      analytics = @client.discovered_api('analytics', API_VERSION)
      File.open(CACHED_API_FILE, 'w') do |file|
        Marshal.dump(analytics, file)
      end
    end
    analytics
  end

  def signing_key
    return if @signing_key
    @signing_key = Google::APIClient::KeyUtils.load_from_pkcs12(KEY_FILE, KEY_SECRET)
  end

  def authorize!
    @client.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      audience: 'https://accounts.google.com/o/oauth2/token',
      scope: 'https://www.googleapis.com/auth/analytics.readonly',
      issuer: SERVICE_ACCOUNT_EMAIL,
      signing_key: signing_key
      )
    @client.authorization.fetch_access_token!
  end

  def get_pvranking(options = {})
    @client.execute(
      api_method: api.data.ga.get,
      parameters: {
        "ids" => "ga:#{VIEW_ID}",
        "start-date" => "2014-01-01", #適宜変更
        "end-date" => "#{Date.today.to_s}", #適宜変更
        "metrics" => "ga:pageviews", #適宜変更
        "dimensions" => "ga:pagePath", #適宜変更
        'filters' => 'ga:pagePath=@/blogs;', #適宜変更
        "sort" => "-ga:pageviews", #適宜変更
        "max-results" => options[:max_results],
        }
      )
  end
end
