module Api
  class Project
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id
    attribute :name
    attribute :url

    def self.parse_projects(data)
      data = JSON.parse(data)

      if data.is_a?(Hash)
        build_project(data)
      elsif data.is_a?(Array)
        data.map { build_project(it) }
      else
        raise "Unsupported data type"
      end
    end

    private

    def self.build_project(data)
      new(
        id: data["id"],
        name: data["name"],
        url: data["web_url"]
      )
    end
  end
end
