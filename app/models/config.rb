# typed: strict

class Config < ApplicationRecord
  extend T::Sig

  encrypts :token
  encrypts :domain

  validates :token, presence: true
  validates :domain, presence: true

  sig { returns(Api::Client) }
  def api_client
    Api::Client.new(token:, domain:)
  end
end
