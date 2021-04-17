class ProjectsRelation < ROM::Relation[:sql]
  gateway :default

  schema(:projects, infer: true)
end
