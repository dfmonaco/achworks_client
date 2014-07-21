require 'spec_helper'

module AchworksClient
  describe Transaction do
    describe '#to_hash' do
      it 'builds the right hash' do
        company = Company.new(company_info: {sss: 'TST',
                                             loc_id: '9505',
                                             company: 'MYCOMPANY',
                                             company_key: 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD'})

        customer = Customer.new(id: 'cust_123',
                                name: 'LAST NAME, FIRST NAME',
                                routing_no: 123456789,
                                acct_no: 'acc_123',
                                acct_type: 'S')

        transaction = Credit.new(company: company,
                                 customer: customer,
                                 amount: 100.25)

        expected_hash = { 'ACHTransRecord' =>
                          {'SSS' => 'TST',
                           'LocID' => '9505',
                           'FrontEndTrace' => transaction.front_end_trace,
                           'OriginatorName' => 'MYCOMPANY',
                           'TransactionCode' => 'PPD',
                           'CustTransType' => 'C',
                           'CustomerID' => 'cust_123',
                           'CustomerName' => 'LAST NAME, FIRST NAME',
                           'CustomerRoutingNo' => 123456789,
                           'CustomerAcctNo' => 'acc_123',
                           'CustomerAcctType' => 'S',
                           'TransAmount' => 100.25,
                           'CheckOrCustID' => 'cust_123',
                           'CheckOrTransDate' => Date.parse('2014-07-17'),
                           'EffectiveDate' => Date.parse('2014-07-17'),
                           'Memo' => 'foo bar',
                           'OpCode' => 'S',
                           'AccountSet' => 1 }
        }

        expect(transaction.to_hash).to eq(expected_hash)
      end
    end

    describe '#cust_trans_type' do
      it 'returns C for Credits and D for Debits' do
        credit = Credit.new

        expect(credit.cust_trans_type).to eq('C')

        debit = Debit.new

        expect(debit.cust_trans_type).to eq('D')
      end
    end

    describe '#front_end_trace' do
      it 'creates a unique value for each transaction per LocID' do
        trans_1 = Transaction.new(company: {company_info: {loc_id: '9505'}})
        trans_2 = Transaction.new(company: {company_info: {loc_id: '9505'}})

        trace_1 = trans_1.front_end_trace
        trace_2 = trans_2.front_end_trace

        expect(trace_1).to_not eq(trace_2)
      end

      it 'has a 12 charachters length' do
        trans = Transaction.new(company: {company_info: {loc_id: '9505'}})

        length = trans.front_end_trace.length

        expect(length).to eq(12)
      end

      it 'does not starts with W' do
        trans = Transaction.new(company: {company_info: {loc_id: 'W505'}})

        first_char = trans.front_end_trace[0]

        expect(first_char).to_not eq('W')
      end
    end


  end
end
