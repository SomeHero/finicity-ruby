module Finicity
  # Abstracting as a class makes it easier since we wont have to redefine the access_token over and over.
  class Partner

    def initialize
      Finicity::Configure::KEYS.each do |key|
        instance_variable_set(:"@#{key}", Finicity.instance_variable_get(:"@#{key}"))
      end
    end

    def authenticate
      xml = "<credentials> <partnerId>2445581240361</partnerId> <partnerSecret>N2DUM99WXbEycslppl6h</partnerSecret> </credentials>"

      @response = post("partners/authentication", xml)

      puts @response
    end

    def post path, xml
      base_url = "https://api.finicity.com/aggregation/v2/"

      url = base_url + path
      RestClient.proxy = ENV["QUOTAGUARDSTATIC_URL"]

      RestClient.post(url, xml, {:content_type => :xml, "Finicity-App-Key" => "30d4600267701941ea2a38b1fa7d7110"}){ |response, request, result, &block|
          case response.code
          when 200
            response
          when 201
            response
          else
            response.return!(request, result, &block)
          end
      }

    end

  end
end
