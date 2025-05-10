module Api
  class Pagination
    def initialize(response)
      @response = response
    end

    def first_page = 1

    def current_page = @response["X-Page"].presence&.to_i

    def next_page = @response["X-Next-Page"].presence&.to_i

    def last_page = @response["X-Total-Pages"].presence&.to_i

    alias_method :total_pages, :last_page

    def prev_page = @response["X-Prev-Page"].presence&.to_i
  end
end
