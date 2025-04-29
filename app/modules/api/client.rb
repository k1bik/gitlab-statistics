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
      url = get_url(path)
      uri = URI(url)
      uri.query = URI.encode_www_form(params.merge(access_token: token))

      Response.new(Net::HTTP.get_response(uri))
    end

    private

    def get_url(path)
      "#{domain}#{path}"
    end
  end
end
