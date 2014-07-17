require 'savon'
require_relative 'trans_result'

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

    def send_ach_trans_batch(company_info, ach_file)
      message = build_message(company_info, ach_file)
      response = client.call(:send_ach_trans_batch, message: message)
      TransResult.new(response)
    end

    private

    attr_reader :client

    def build_message(*args)
      args.reduce({}) do |message, arg|
        message.merge(arg.to_hash)
      end
    end

    # let's cache the file for now
    def wsdl
      'wsdl.xml'
    end
  end
end

