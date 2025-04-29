require "net/http"

module Api
  class Client
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :domain
    attribute :token

    validates :domain, presence: true
    validates :token, presence: true

    def get(path, params: nil)
      url = get_url(path)
      uri = URI(url)

      if params
        uri.query = URI.encode_www_form(params)
      end

      Response.new(Net::HTTP.get_response(uri))
    end

    private

    def get_url(path)
      "#{domain}#{path}?access_token=#{token}"
    end
  end
end
