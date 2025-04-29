module Api
  class Response
    def initialize(response)
      @response = response
    end

    def success?
      @response.class.name == "Net::HTTPOK"
    end

    def body
      @response.body
    end
  end
end
