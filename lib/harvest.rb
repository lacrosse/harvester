require 'harvested'

module Harvest
  CREDENTIALS = CREDENTIALS['harvest'].values_at('subdomain', 'username', 'password')
  GATEWAY = Harvest.hardy_client(*CREDENTIALS)
end
