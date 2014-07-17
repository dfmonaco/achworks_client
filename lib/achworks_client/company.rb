require_relative 'company_info'
require_relative 'client'

module AchworksClient
  class Company
    extend Forwardable
    include Virtus.model

    attribute :company_info, CompanyInfo, default: CompanyInfo.new
    attribute :client, Client, default: Client.new, accessor: :private

    def_delegators :company_info, :sss, :loc_id
    def_delegators :ach_file, :count_transactions
    def_delegator :company_info, :company, :name

    def valid_account?
      client.connection_check(company_info)
    end

    def send_transactions
      client.send_ach_trans_batch(company_info, ach_file)
    end

    def add_transaction(transaction)
      transaction.company = self
      ach_file << transaction
    end

    private

    def ach_file
      @ach_file ||= ACHFile.new(self)
    end

  end
end
