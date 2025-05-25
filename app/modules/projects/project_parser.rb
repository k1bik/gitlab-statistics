# typed: strict

module Projects
  class ProjectParser
    class << self
      extend T::Sig

      sig { params(data: String).returns(T.any(T::Array[ProjectStruct], ProjectStruct)) }
      def parse(data)
        parsed_data = JSON.parse(data)

        case parsed_data
        when Hash
          build_project(parsed_data)
        when Array
          parsed_data.map { |data| build_project(data) }
        else
          raise "Unsupported data type"
        end
      end

      private

      sig { params(data: T::Hash[String, T.untyped]).returns(ProjectStruct) }
      def build_project(data)
        if (owner = data["owner"])
          project_owner = Projects::ProjectOwnerStruct.new(
            id: owner["id"],
            name: owner["name"],
            web_url: owner["web_url"],
            avatar_url: owner["avatar_url"]
          )
        end

        Projects::ProjectStruct.new(
          id: data["id"],
          name: data["name"],
          web_url: data["web_url"],
          description: data["description"],
          created_at: Common::Utils.format_date(data["created_at"]),
          updated_at: Common::Utils.format_date(data["updated_at"] || data["created_at"]),
          owner: project_owner
        )
      end
    end
  end
end
