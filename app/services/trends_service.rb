require 'httparty'

class TrendsService
  include HTTParty
  base_uri 'https://api.twitter.com'

  def get
    oauth = JSON.parse(token.body)
    access_token = oauth['access_token']
    options = {}
    options[:headers] = {'Authorization' => "Bearer #{access_token}"}
    self.class.get('/1.1/trends/place.json?id=	1', options)
  end

  def token
    options = {}
    options[:body] = 'grant_type=client_credentials'
    options[:headers] = {'Authorization' => basic_encoded}
    self.class.post('/oauth2/token', options)
  end

  def basic_encoded
    'Basic ' + Base64.strict_encode64(customer_key + ':' + customer_secret)
  end

  def customer_key
    Rails.application.config.x.twitter.api_key
  end

  def customer_secret
    Rails.application.config.x.twitter.api_secret
  end
end