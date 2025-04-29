module Api
  class Pagination
    def initialize(response)
      @response = response
    end

    def current_page
      @response["X-Page"].presence&.to_i
    end

    def next_page
      @response["X-Next-Page"].presence&.to_i
    end

    def total_pages
      @response["X-Total-Pages"].presence&.to_i
    end

    def prev_page
      @response["X-Prev-Page"].presence&.to_i
    end
  end
end
