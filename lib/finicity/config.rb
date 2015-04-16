module Finicity
  module Configure
    attr_writer :base_url, :api_key, :partner_id, :partner_secret, :is_testing

    KEYS = [:base_url, :api_key, :partner_id, :partner_secret, :is_testing]

    def config
      yield self
      self
    end

  end
end
