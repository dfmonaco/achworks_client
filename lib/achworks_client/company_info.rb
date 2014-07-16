module AchworksClient
  class CompanyInfo
    def initialize(info={})
      @info = info
    end

    def to_hash
      {'InpCompanyInfo' =>
       {'SSS' => info.fetch(:sss, ENV['ACHW_SSS']),
        'LocID' => info.fetch(:loc_id, ENV['ACHW_LocID']),
        'Company' => info.fetch(:company, ENV['ACHW_Company']),
        'CompanyKey' => info.fetch(:company_key, ENV['ACHW_CompanyKey'])}
      }
    end

    private

    attr_reader :info
  end
end

