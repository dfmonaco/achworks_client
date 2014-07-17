module AchworksClient
  class TransResult
    def initialize(response)
      @response = response
    end

    def success?
      result = response.body[:send_ach_trans_batch_response][:send_ach_trans_batch_result]
      return true if result[:status] == "SUCCESS"
      false
    end

    private

    attr_reader :response

  end
end

