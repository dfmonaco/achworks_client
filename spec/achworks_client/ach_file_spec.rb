require 'spec_helper'

module AchworksClient
  describe ACHFile do
    describe '#to_hash' do
      it 'builds the right hash' do
        company = Company.new(company_info: {sss: 'TST',
                                             loc_id: '9505',
                                             company: 'MYCOMPANY',
                                             company_key: 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD'})
        ach_file = ACHFile.new(company: company)

        expected_hash = {'InpACHFile' =>
                         {'SSS' => 'TST',
                          'LocID' => '9505',
                          'ACHFileName' => '',
                          'TotalNumRecords' => 0,
                          'TotalDebitRecords' => 0,
                          'TotalDebitAmount' => 0,
                          'TotalCreditRecords' => 0,
                          'TotalCreditAmount' => 0,
                          'ACHRecords' => {}}
        }

        expect(ach_file.to_hash).to eq(expected_hash)
      end
    end

    describe '#total_num_records' do
      it 'returns the total number of transactions' do
        ach_file = ACHFile.new

        ach_file << Credit.new
        ach_file << Debit.new

        expect(ach_file.total_num_records).to eq(2)
      end
    end

    describe '#total_debit_records' do
      it 'returns the total number of debits' do
        ach_file = ACHFile.new

        ach_file << Debit.new
        ach_file << Debit.new
        ach_file << Credit.new

        expect(ach_file.total_debit_records).to eq(2)
      end
    end

    describe '#total_debit_amount' do
      it 'returns the total debit amount' do
        ach_file = ACHFile.new

        ach_file << Debit.new(amount: 100.25)
        ach_file << Debit.new(amount: 200.50)
        ach_file << Credit.new(amount: 1000)

        expect(ach_file.total_debit_amount).to eq(300.75)
      end
    end

    describe '#total_credit_records' do
      it 'returns the total number of credits' do
        ach_file = ACHFile.new

        ach_file << Credit.new
        ach_file << Credit.new
        ach_file << Debit.new

        expect(ach_file.total_credit_records).to eq(2)
      end
    end

    describe '#total_credit_amount' do
      it 'returns the total credit amount' do
        ach_file = ACHFile.new

        ach_file << Credit.new(amount: 100.25)
        ach_file << Credit.new(amount: 200.50)
        ach_file << Debit.new(amount: 1000)

        expect(ach_file.total_credit_amount).to eq(300.75)
      end
    end
  end
end
