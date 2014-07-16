require 'savon'

module AchworksClient
  class Company
    def initialize
      set_company_info
      set_client
    end

    def valid_account?
      response = client.call(:connection_check, message: company_info)
      case response.body[:connection_check_response][:connection_check_result]
      when 'SUCCESS:Valid Account' then true
      when 'REJECTED:Invalid Account' then false
      end
    end

    private

    attr_reader :company_info, :client

    def set_company_info
      @company_info = {'InpCompanyInfo' =>
                        {'SSS' => ENV['SSS'],
                         'LocID' => ENV['LocID'],
                         'Company' => ENV['Company'],
                         'CompanyKey' => ENV['CompanyKey']}
                       }
    end

    def set_client
      @client = Savon.client(wsdl: 'http://tstsvr.achworks.com/dnet/achws.asmx?WSDL')
    end

  end
end
