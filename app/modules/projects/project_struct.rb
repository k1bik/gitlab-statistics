# typed: strict

module Projects
  class ProjectStruct < T::Struct
    extend T::Sig

    const :id, Integer
    const :name, String
    const :web_url, String
    const :description, T.nilable(String)
    const :created_at, String
    const :updated_at, String
    const :owner, T.nilable(ProjectOwnerStruct)
  end
end
