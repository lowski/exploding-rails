class ProjectContract < Dry::Validation::Contract
  schema do
    required(:name).filled(:string)
  end
end
