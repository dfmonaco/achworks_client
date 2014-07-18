module AchworksClient
  class ACHFile
    extend Forwardable
    include Virtus.model

    attribute :company, Company

    def_delegators :transactions, :<<
    def_delegators :company, :sss, :loc_id
    def_delegator :transactions, :size, :count_transactions

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
      debits.size
    end

    def total_debit_amount
      debits.reduce(0) do |sum, debit|
        sum + debit.amount
      end
    end

    def total_credit_records
      0
    end

    def total_credit_amount
      0
    end

    private

    def transactions
      @transactions ||= []
    end

    def debits
      transactions.select do |transaction|
        transaction.is_a?(Debit)
      end
    end

    def build_transactions_hash
      transactions.reduce({}) do |transactions_hash, transaction|
        transactions_hash.merge(transaction.to_hash)
      end
    end
  end
end





