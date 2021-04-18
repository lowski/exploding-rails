module Entities
  class Project < Entity
    def self.model_name
      ActiveModel::Name.new(self, nil, 'Project')
    end
  end
end
