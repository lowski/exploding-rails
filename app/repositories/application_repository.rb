class ApplicationRepository < ROM::Repository::Root
  auto_struct true

  struct_namespace ::Entities

  def build(attributes = {})
    root.mapper.model.new(attributes)
  end

  def by_id(id)
    root.by_pk(id).one!
  end

  def all
    root.to_a
  end
end
