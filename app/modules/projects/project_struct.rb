# typed: strict

module Projects
  class ProjectStruct < T::Struct
    extend T::Sig

    const :id, Integer
    const :name, String
    const :web_url, String
    const :description, T.nilable(String)
  end
end
