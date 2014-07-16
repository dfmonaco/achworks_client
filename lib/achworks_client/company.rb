require_relative 'company_info'
require_relative 'client'

module AchworksClient
  class Company
    def initialize(company_info = CompanyInfo.new, client = Client.new)
      @company_info = company_info
      @client = client
    end

    def valid_account?
      client.connection_check(company_info)
    end

    private

    attr_reader :company_info, :client

  end
end
