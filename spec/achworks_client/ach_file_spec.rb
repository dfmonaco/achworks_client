require 'spec_helper'

module AchworksClient
  describe ACHFile do
    describe '#to_hash' do
      it 'builds the right hash' do
        company = Company.new(company_info: {sss: 'TST',
                                             loc_id: '9505',
                                             company: 'MYCOMPANY',
                                             company_key: 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD'})
        ach_file = ACHFile.new(company)

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
  end
end
