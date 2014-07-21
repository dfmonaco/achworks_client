module AchworksClient
  class Transaction
    extend Forwardable
    include Virtus.model

    attribute :company, Company
    attribute :customer, Customer
    attribute :amount, BigDecimal
    attribute :transaction_code, String, default: 'PPD'
    attribute :check_or_trans_date, Date, default: Date.today
    attribute :effective_date, Date, default: Date.today
    attribute :memo, String
    attribute :op_code, String, default: 'S'

    def_delegators :company, :sss, :loc_id
    def_delegator :company, :name, :originator_name
    def_delegator :customer, :id, :customer_id
    def_delegator :customer, :name, :customer_name
    def_delegator :customer, :routing_no, :customer_routing_no
    def_delegator :customer, :acct_no, :customer_acct_no
    def_delegator :customer, :acct_type, :customer_acct_type

    alias_method :trans_amount, :amount
    alias_method :check_or_cust_id, :customer_id

    def to_hash
      { 'ACHTransRecord' =>
        {'SSS' => sss,
         'LocID' => loc_id,
         'FrontEndTrace' => front_end_trace,
         'OriginatorName' => originator_name,
         'TransactionCode' => transaction_code,
         'CustTransType' => cust_trans_type,
         'CustomerID' => customer_id,
         'CustomerName' => customer_name,
         'CustomerRoutingNo' => customer_routing_no,
         'CustomerAcctNo' => customer_acct_no,
         'CustomerAcctType' => customer_acct_type,
         'TransAmount' => trans_amount,
         'CheckOrCustID' => check_or_cust_id,
         'CheckOrTransDate' => check_or_trans_date,
         'EffectiveDate' => effective_date,
         'Memo' => memo,
         'OpCode' => op_code,
         'AccountSet' => account_set}
      }
    end

    def front_end_trace
      unique_value = SecureRandom.hex(4)
      @front_end_trace ||= "#{unique_value}#{loc_id}"
    end

    def account_set
      1
    end

    def cust_trans_type
      is_a?(Credit) ? 'C' : 'D'
    end
  end

  class Credit < Transaction
  end
  class Debit < Transaction
  end
end
