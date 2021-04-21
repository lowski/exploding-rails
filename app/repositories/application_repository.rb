class ApplicationRepository < ROM::Repository::Root
  auto_struct true

  struct_namespace ::Entities

  def all
    root.to_a
  end

  def build(attributes = {})
    root.mapper.model.new(attributes)
  end

  def by_id(id)
    root.by_pk(id).one!
  end

  alias find by_id
end
