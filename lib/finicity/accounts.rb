module Finicity
  # Abstracting as a class makes it easier since we wont have to redefine the access_token over and over.
  class Accounts

    def initialize
      Finicity::Configure::KEYS.each do |key|
        instance_variable_set(:"@#{key}", Finicity.instance_variable_get(:"@#{key}"))
      end
    end

    def discover token, customer_id, institution_id, login_fields
      xml = "<accounts> <credentials>"
      login_fields.each do |login_field|
        xml += "<loginField> <id>#{login_field[:field_id]}</id> <name>#{login_field[:field_name]}</name> <value>#{login_field[:field_value]}</value> </loginField>"
      end
      xml += "</credentials> </accounts>"

      url = "v1/customers/#{customer_id}/institutions/#{institution_id}/accounts"

      @response = post(url, token, xml)
    end

    def discover_with_mfa token, mfa_session_token, customer_id, institution_id, login_fields, mfa_question, mfa_answer
      xml = "<accounts> <credentials>"
      login_fields.each do |login_field|
        xml += "<loginField> <id>#{login_field[:field_id]}</id> <name>#{login_field[:field_name]}</name> <value>#{login_field[:field_value]}</value> </loginField>"
      end  
      xml += "</credentials> <mfaChallenges> <questions> <question> <text>#{mfa_question}</text> <answer>#{mfa_answer}</answer> </question> </questions> </mfaChallenges> </accounts>"

      url = "v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/mfa"

      @response = post_mfa(url, token, mfa_session_token, xml)
    end

    def activate token, customer_id, institution_id, account_id, account_number, account_name, account_type
      xml = "<accounts> <account> <id>#{account_id}</id> <number>#{account_number}</number> <name>#{account_name}</name> <type>#{account_type}</type> </account> </accounts>"

      url = "v1/customers/#{customer_id}/institutions/#{institution_id}/accounts"

      @response = put(url, token, xml)
    end

    def activate_with_mfa token, mfa_session_token, customer_id, institution_id, account_id, account_number, account_name, account_type, mfa_question, mfa_answer
      xml = "<accounts> <account> <id>#{account_id}</id> <number>#{account_number}</number> <name>#{account_name}</name> <type>#{account_type}</type> </account> <mfaChallenges> <questions> <question> <text>#{mfa_question}</text> <answer>#{mfa_answer}</answer> </question> </questions> </mfaChallenges> </accounts>"

      url = "v1/customers/#{customer_id}/institutions/#{institution_id}/accounts/mfa"

      @response = put_mfa(url, token, mfa_session_token, xml)
    end

    def get_accounts token, customer_id
      url = "v1/customers/#{customer_id}/accounts"

      @response = post(url, token, nil)
    end

    def post  path, token, xml
      base_url = self.instance_variable_get(:'@base_url')

      url = base_url + path
      RestClient.proxy = ENV["QUOTAGUARDSTATIC_URL"]

      RestClient.post(url, xml, {:content_type => :xml, "Finicity-App-Key" => self.instance_variable_get(:'@api_key'), "Finicity-App-Token" => token}){ |response, request, result, &block|
        Rails.logger.debug response

        case response.code
          when 200
            response
          when 201
            response
          when 203
            response
          when 500
            res = Hash.from_xml(response)

            case res["error"]["code"]
              when "103"
                response
              when "203"
                response
              else
                response.return!(request, result, &block)
              end
          else
            response.return!(request, result, &block)
          end
      }
    end

    def post_mfa path, token, mfa_session, xml
      base_url = self.instance_variable_get(:'@base_url')

      url = base_url + path
      RestClient.proxy = ENV["QUOTAGUARDSTATIC_URL"]

      RestClient.post(url, xml, {:content_type => :xml, "Finicity-App-Key" => self.instance_variable_get(:'@api_key'), "Finicity-App-Token" => token, "MFA-Session" => mfa_session}){ |response, request, result, &block|
        Rails.logger.debug response

        case response.code
          when 200
            response
          when 201
            response
          when 203
            response
          when 500
            res = Hash.from_xml(response)

            case res["error"]["code"]
              when "103"
                response
              when "325"
                response
              else
                response.return!(request, result, &block)
              end
          else
            response.return!(request, result, &block)
          end
      }
    end

    def put path, token, xml
      base_url = self.instance_variable_get(:'@base_url')

      url = base_url + path
      RestClient.proxy = ENV["QUOTAGUARDSTATIC_URL"]

      RestClient.put(url, xml, {:content_type => :xml, "Finicity-App-Key" => self.instance_variable_get(:'@api_key'), "Finicity-App-Token" => token}){ |response, request, result, &block|
        Rails.logger.debug response

        case response.code
          when 200
            response
          when 201
            response
          when 203
            response
          when 500
            res = Hash.from_xml(response)

            case res["error"]["code"]
              when "103"
                response
              when "325"
                response
              else
                response.return!(request, result, &block)
              end
          else
            response.return!(request, result, &block)
          end
      }
    end

    def put_mfa path, token, mfa_session, xml
      base_url = self.instance_variable_get(:'@base_url')

      url = base_url + path
      RestClient.proxy = ENV["QUOTAGUARDSTATIC_URL"]

      RestClient.put(url, xml, {:content_type => :xml, "Finicity-App-Key" => self.instance_variable_get(:'@api_key'), "Finicity-App-Token" => token, "MFA-Session" => mfa_session}){ |response, request, result, &block|
        Rails.logger.debug response

        case response.code
          when 200
            response
          when 201
            response
          when 203
            response
          when 500
            res = Hash.from_xml(response)

            case res["error"]["code"]
              when "103"
                response
              when "325"
                response
              else
                response.return!(request, result, &block)
              end
          else
            response.return!(request, result, &block)
          end
      }
    end
  end
end
