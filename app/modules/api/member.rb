# typed: strict

module Api
  class Member
    extend T::Sig
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id
    attribute :name
    attribute :avatar_url

    sig { params(data: String).returns(T.any(T::Array[Api::Member], Api::Member)) }
    def self.parse_members(data)
      data = JSON.parse(data)

      if data.is_a?(Hash)
        build_member(data)
      elsif data.is_a?(Array)
        data.map { build_member(_1) }
      else
        raise "Unsupported data type"
      end
    end

    private

    sig { params(data: T::Hash[String, String]).returns(Api::Member) }
    def self.build_member(data)
      new(
        id: data["id"],
        name: data["name"],
        avatar_url: data["avatar_url"]
      )
    end
  end
end
