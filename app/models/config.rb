class Config < ApplicationRecord
  encrypts :token
  encrypts :domain

  validates :token, presence: true
  validates :domain, presence: true

  def api_client
    Api::Client.new(token:, domain:)
  end
end
