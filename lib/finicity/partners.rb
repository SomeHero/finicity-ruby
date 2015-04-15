module Finicity
  # Abstracting as a class makes it easier since we wont have to redefine the access_token over and over.
  class Partners

    def initialize
      Finicity::Configure::KEYS.each do |key|
        instance_variable_set(:"@#{key}", Finicity.instance_variable_get(:"@#{key}"))
      end
    end

    def authenticate
      partner_id = self.instance_variable_get(:'@partner_id')
      partner_secret = self.instance_variable_get(:'@partner_secret')

      xml = "<credentials> <partnerId>#{partner_id}</partnerId> <partnerSecret>#{partner_secret}</partnerSecret> </credentials>"

      @response = post("v2/partners/authentication", xml)

      hash = Hash.from_xml(@response)

      hash["access"]["token"]
    end

    def post path, xml
      base_url = self.instance_variable_get(:'@base_url')

      url = base_url + path

      RestClient.proxy = ENV["QUOTAGUARDSTATIC_URL"]

      RestClient.post(url, xml, {:content_type => :xml, "Finicity-App-Key" => self.instance_variable_get(:'@api_key')}){ |response, request, result, &block|
        Rails.logger.debug response

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
