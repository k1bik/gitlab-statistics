class Config < ApplicationRecord
  encrypts :token
  encrypts :domain

  validates :token, presence: true
  validates :domain, presence: true
end
