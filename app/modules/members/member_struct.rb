# typed: strict

module Members
  class MemberStruct < T::Struct
    extend T::Sig

    const :id, Integer
    const :name, String
    const :avatar_url, String
  end
end
