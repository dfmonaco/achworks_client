require 'spec_helper'

module AchworksClient
  describe Company do
    let(:company) do
      Company.new(company_info: {sss: 'TST',
                                 loc_id: '9505',
                                 company: 'MYCOMPANY',
                                 company_key: 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD'})
    end

    describe '#valid_account?', :vcr do
      it 'returns true if the account is valid' do
        expect(company.valid_account?).to be true
      end

      it 'returns false if the account is invalid' do
        invalid_info = CompanyInfo.new(sss: 'TST',
                                       loc_id: '9505',
                                       company: 'INVALID',
                                       company_key: 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD')

        invalid_company = Company.new(invalid_info)

        expect(invalid_company.valid_account?).to be false
      end
    end

    describe '#add_transaction' do
      it 'adds a new transaction' do
        transaction = Transaction.new
        company.add_transaction(transaction)

        expect(transaction.company).to be(company)
        expect(company.count_transactions).to eq(1)
      end
    end

    describe '#send_transactions' do
      it 'sends multiple transactions' do
        trans_result = company.send_transactions

        expect(trans_result.success?).to be(true)
      end
    end

  end
end
