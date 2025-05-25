# typed: strict

module Projects
  class ProjectOwnerStruct < T::Struct
    extend T::Sig

    const :id, Integer
    const :name, String
    const :web_url, String
    const :avatar_url, T.nilable(String)
  end
end
