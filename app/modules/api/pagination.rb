# typed: strict

module Api
  class Pagination
    extend T::Sig

    sig { params(response: Net::HTTPResponse).void }
    def initialize(response)
      @response = response
    end

    sig { returns(Integer) }
    def first_page = 1

    sig { returns(Integer) }
    def current_page = @response["X-Page"].presence&.to_i

    sig { returns(Integer) }
    def next_page = @response["X-Next-Page"].presence&.to_i

    sig { returns(Integer) }
    def last_page = @response["X-Total-Pages"].presence&.to_i

    sig { returns(Integer) }
    def total_pages = @response["X-Total-Pages"].presence&.to_i

    sig { returns(Integer) }
    def prev_page = @response["X-Prev-Page"].presence&.to_i
  end
end
