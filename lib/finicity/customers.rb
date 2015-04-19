module Finicity
  # Abstracting as a class makes it easier since we wont have to redefine the access_token over and over.
  class Customers

    def initialize
      Finicity::Configure::KEYS.each do |key|
        instance_variable_set(:"@#{key}", Finicity.instance_variable_get(:"@#{key}"))
      end
    end
    def add_customer token, username, first_name, last_name, email_address
      xml = "<customer> <username>#{username}</username> <firstName>James</firstName> <lastName>Rhodes</lastName></customer>"

      if(self.instance_variable_get(:'@is_testing') == "true")
         Rails.logger.debug "Using test customer endpoint"
         url = "v1/customers/testing"
      else
        Rails.logger.debug "Using active customer endpoint"
        url = "v1/customers/active"
      end

      @response = post(url, token, xml)

      hash = Hash.from_xml(@response)

      hash
    end

    def post path, token, xml
      base_url = self.instance_variable_get(:'@base_url')

      url = base_url + path
      RestClient.proxy = ENV["QUOTAGUARDSTATIC_URL"]

      RestClient.post(url, xml, {:content_type => :xml, "Finicity-App-Key" => self.instance_variable_get(:'@api_key'), "Finicity-App-Token" => token}){ |response, request, result, &block|
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
