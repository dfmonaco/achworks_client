require 'spec_helper'

module AchworksClient
  describe CompanyInfo do
    describe '#to_hash' do
      it 'gets info from params' do
        company_info = CompanyInfo.new(sss: 'foo',
                                       loc_id: 'bar',
                                       company: 'baz',
                                       company_key: 'qux')

        expected_hash = {'InpCompanyInfo' =>
                          {'SSS' => 'foo',
                           'LocID' => 'bar',
                           'Company' => 'baz',
                           'CompanyKey' => 'qux'}
                        }

        expect(company_info.to_hash).to eq(expected_hash)
      end

      it 'gets info from ENV' do
        ENV['ACHW_SSS'], ENV['ACHW_LocID'], ENV['ACHW_Company'], ENV['ACHW_CompanyKey'] = 'foo', 'bar', 'baz', 'qux'

        company_info = CompanyInfo.new

        expected_hash = {'InpCompanyInfo' =>
                          {'SSS' => 'foo',
                           'LocID' => 'bar',
                           'Company' => 'baz',
                           'CompanyKey' => 'qux'}
                        }

        expect(company_info.to_hash).to eq(expected_hash)
      end
    end
  end
end
