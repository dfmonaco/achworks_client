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

        transaction = Transaction.new(company: company,
                                      customer: customer,
                                      amount: 100.25)

        expected_hash = { 'ACHTransRecord' =>
                          {'SSS' => 'TST',
                           'LocID' => '9505',
                           'FrontEndTrace' => 'abc1234567',
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
  end
end
