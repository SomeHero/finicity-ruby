module Finicity
  module Configure
    attr_writer :base_url, :customer_id, :secret

    KEYS = [:base_url, :customer_id, :secret]

    def config
      yield self
      self
    end

  end
end
