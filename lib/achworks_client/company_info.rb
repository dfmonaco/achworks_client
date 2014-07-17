module AchworksClient
  class CompanyInfo
    include Virtus.model

    attribute :sss, String
    attribute :loc_id, String
    attribute :company, String
    attribute :company_key, String

    def to_hash
      {'InpCompanyInfo' =>
       {'SSS' => sss || ENV['ACHW_SSS'],
        'LocID' => loc_id || ENV['ACHW_LocID'],
        'Company' => company || ENV['ACHW_Company'],
        'CompanyKey' => company_key || ENV['ACHW_CompanyKey']}
      }
    end

  end
end

