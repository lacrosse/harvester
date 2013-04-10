require 'quickeebooks'
require 'oauth'

module Qbo
  raise NotImplementedError unless CREDENTIALS = CREDENTIALS['qbo']

  qb_oauth_consumer = OAuth::Consumer.new(*CREDENTIALS['app'].values_at('key', 'secret'), {
    :site                 => "https://oauth.intuit.com",
    :request_token_path   => "/oauth/v1/get_request_token",
    :authorize_url        => "https://appcenter.intuit.com/Connect/Begin",
    :access_token_path    => "/oauth/v1/get_access_token"
  })

  oauth_client = OAuth::AccessToken.new(qb_oauth_consumer, *CREDENTIALS['account'].values_at('token', 'secret'))

  gate = Quickeebooks::Online::Service::Customer.new
  gate.access_token = oauth_client
  gate.realm_id = CREDENTIALS['account']['realm'].to_i

  GATEWAY = gate
end
