require 'harvested'

module Harvest
  CREDENTIALS = CREDENTIALS['harvest'].values_at('subdomain', 'username', 'password')
  GATEWAY = Harvest.hardy_client(*CREDENTIALS)

  def self.invoices_total
    GATEWAY.invoices.all.map{ |i| i.amount.to_f }.inject(0, :+)
  end
end
