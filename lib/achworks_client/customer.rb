module AchworksClient
  class Customer
    include Virtus.model

    attribute :id, String
    attribute :name, String
    attribute :routing_no, Integer
    attribute :acct_no, String
    attribute :acct_type, String


  end
end
