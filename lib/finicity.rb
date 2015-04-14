require 'finicity/config'
require 'finicity/partner'
require 'rest_client'

module Finicity
  class << self
    include Finicity::Configure

    def partner
      @partner = Finicity::Partner.new
    end

  end
end
