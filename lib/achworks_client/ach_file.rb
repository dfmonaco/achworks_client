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
      total_amount(debits)
    end

    def total_credit_records
      credits.size
    end

    def total_credit_amount
      total_amount(credits)
    end

    private

    def transactions
      @transactions ||= []
    end

    def credits
      transactions.select do |transaction|
        transaction.is_a?(Credit)
      end
    end

    def debits
      transactions - credits
    end

    def total_amount(transactions)
      transactions.reduce(0) do |sum, transaction|
        sum + transaction.amount
      end
    end

    def build_transactions_hash
      transactions.reduce({}) do |transactions_hash, transaction|
        transactions_hash.merge(transaction.to_hash)
      end
    end
  end
end





