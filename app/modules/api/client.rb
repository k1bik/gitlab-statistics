# typed: strict

require "net/http"

module Api
  class Client
    extend T::Sig
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :domain
    attribute :token

    validates :domain, presence: true
    validates :token, presence: true

    sig { params(path: String, params: T.untyped).returns(Api::Response) }
    def get(path, **params)
      uri = build_uri(path, params)
      request = Net::HTTP::Get.new(uri)
      execute_request(request)
    end

    private

    sig { params(path: String, params: T.untyped).returns(URI) }
    def build_uri(path, params)
      url = "#{domain}#{path}"
      uri = URI(url)
      uri.query = URI.encode_www_form(params) if params.any?

      uri
    end

    sig { params(request: Net::HTTPRequest).returns(Api::Response) }
    def execute_request(request)
      request["PRIVATE-TOKEN"] = token
      request["Accept"] = "application/json"

      http = Net::HTTP.new(request.uri.host, request.uri.port)
      http.use_ssl = request.uri.scheme == "https"

      response = http.request(request)
      Response.new(response)
    end
  end
end
