# typed: strict

module Members
  class MemberParser
    class << self
      extend T::Sig

      # TODO: method is the same in both Members::MemberParser and Projects::ProjectParser
      sig { params(data: String).returns(T.any(T::Array[MemberStruct], MemberStruct)) }
      def parse(data)
        parsed_data = JSON.parse(data)

        case parsed_data
        when Hash
          build_member(parsed_data)
        when Array
          parsed_data.map { |data| build_member(data) }
        else
          raise "Unsupported data type"
        end
      end

      private

      sig { params(data: T::Hash[String, T.untyped]).returns(MemberStruct) }
      def build_member(data)
        Members::MemberStruct.new(
          id: data["id"],
          name: data["name"],
          avatar_url: data["avatar_url"]
        )
      end
    end
  end
end
