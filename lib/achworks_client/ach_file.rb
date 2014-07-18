module AchworksClient
  class ACHFile
    extend Forwardable

    def_delegators :transactions, :<<
    def_delegators :company, :sss, :loc_id
    def_delegator :transactions, :size, :count_transactions

    def initialize(company)
      @company = company
      @transactions = []
    end

    def to_hash
      {'InpACHFile' =>
        {'SSS' => sss,
         'LocID' => loc_id,
         'ACHFileName' => ach_file_name,
         'TotalNumRecords' => total_num_records,
         'TotalDebitRecords' => total_debit_records,
         'TotalDebitAmount' => total_debit_amount,
         'TotalCreditRecords' => total_credit_records,
         'TotalCreditAmount' => total_credit_amount,
         'ACHRecords' => build_transactions_hash}
      }
    end

    def ach_file_name
      ''
    end

    def total_num_records
      count_transactions
    end

    def total_debit_records
      0
    end

    def total_debit_amount
      0
    end

    def total_credit_records
      0
    end

    def total_credit_amount
      0
    end

    private

    attr_reader :transactions, :company

    def build_transactions_hash
      transactions.reduce({}) do |transactions_hash, transaction|
        transactions_hash.merge(transaction.to_hash)
      end
    end
  end
end





