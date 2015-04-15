require 'finicity/config'
require 'finicity/partners'
require 'finicity/accounts'
require 'finicity/customers'
require 'rest_client'

module Finicity
  class << self
    include Finicity::Configure

    def partners
      @partners = Finicity::Partners.new
    end

    def customers
      @customers = Finicity::Customers.new
    end

    def accounts
      @accounts = Finicity::Accounts.new
    end
  end
end
