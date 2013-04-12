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

  gate = Quickeebooks::Online::Service::Account.new
  gate.access_token = oauth_client
  gate.realm_id = CREDENTIALS['account']['realm'].to_i

  ACCOUNTS = gate

  # Returns current balance of configured account
  def self.account_balance(id)
    (balance = ACCOUNTS.fetch_by_id(id).current_balance) ? balance : "nil"
  end

  def self.balances
    array = []
    CREDENTIALS['account']['bank_account_ids'].each do |id|
      array << [id, account_balance(id)]
    end
    array
  end

  # Outputs all of QBO accounts in the following format:
  # id  balance  name
  def self.list_accounts
    ACCOUNTS.list([], 1, 100).entries.each do |acc|
      puts "#{acc.id}\t#{acc.current_balance}\t#{acc.name}"
    end
  end
end
