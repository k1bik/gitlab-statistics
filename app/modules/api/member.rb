module Api
  class Member
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id
    attribute :name
    attribute :avatar_url

    def self.parse_members(data)
      data = JSON.parse(data)

      if data.is_a?(Hash)
        build_member(data)
      elsif data.is_a?(Array)
        data.map { build_member(it) }
      else
        raise "Unsupported data type"
      end
    end

    private

    def self.build_member(data)
      new(
        id: data["id"],
        name: data["name"],
        avatar_url: data["avatar_url"]
      )
    end
  end
end
