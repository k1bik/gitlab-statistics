require "net/http"

module Api
  class Client
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :domain
    attribute :token

    validates :domain, presence: true
    validates :token, presence: true

    def get(path, **params)
      uri = build_uri(path, params)
      request = Net::HTTP::Get.new(uri)
      execute_request(request)
    end

    private

    def build_uri(path, params)
      url = "#{domain}#{path}"
      uri = URI(url)
      uri.query = URI.encode_www_form(params) if params.any?
      uri
    end

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
