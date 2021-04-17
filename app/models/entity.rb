class Entity < ROM::Struct
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def self.inherited(klass)
    super

    klass.transform_types { |t| t.omittable }
  end

  def persisted?
    try(:id).present?
  end
end
