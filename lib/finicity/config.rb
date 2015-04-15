module Finicity
  module Configure
    attr_writer :base_url, :api_key, :partner_id, :partner_secret

    KEYS = [:base_url, :api_key, :partner_id, :partner_secret]

    def config
      yield self
      self
    end

  end
end
