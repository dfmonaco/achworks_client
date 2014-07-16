require 'savon'

module AchworksClient
  class Client
    def initialize
      @client = Savon.client(wsdl: wsdl, pretty_print_xml: true)
    end

    def connection_check(company_info)
      response = client.call(:connection_check, message: company_info.to_hash)
      case response.body[:connection_check_response][:connection_check_result]
      when 'SUCCESS:Valid Account' then true
      when 'REJECTED:Invalid Account' then false
      end
    end

    private

    attr_reader :client

    # let's cache the file for now
    def wsdl
      'wsdl.xml'
    end

  end
end

