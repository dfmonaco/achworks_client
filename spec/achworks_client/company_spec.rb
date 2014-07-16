require 'spec_helper'

module AchworksClient
  describe Company do
    describe '#valid_account?', :vcr do
      it 'returns true if the account is valid' do
        company_info = CompanyInfo.new(sss: 'TST',
                                       loc_id: '9505',
                                       company: 'MYCOMPANY',
                                       company_key: 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD')


        company = Company.new(company_info)

        expect(company.valid_account?).to be true
      end

      it 'returns false if the account is invalid' do
        company_info = CompanyInfo.new(sss: 'TST',
                                       loc_id: '9505',
                                       company: 'INVALID',
                                       company_key: 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD')

        company = Company.new(company_info)

        expect(company.valid_account?).to be false
      end
    end
  end
end
