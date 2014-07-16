require 'spec_helper'

module AchworksClient
  describe Company do
    describe '#valid_account?' do
      it 'returns true if the account is valid' do
        ENV['SSS'], ENV['LocID'], ENV['Company'], ENV['CompanyKey'] = 'TST', '9505', 'MYCOMPANY', 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD'

        company = Company.new

        expect(company.valid_account?).to be true
      end

      it 'returns false if the account is invalid' do
        ENV['SSS'], ENV['LocID'], ENV['Company'], ENV['CompanyKey'] = 'TST', '9505', 'INVALID', 'SASD%!%$DGLJGWYRRDGDDUDFDESDHDD'

        company = Company.new

        expect(company.valid_account?).to be false
      end
    end
  end
end
