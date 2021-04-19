require 'dry/monads'
require 'dry/monads/do'

class ProjectContext
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:create)

  def initialize(repo, contract)
    @repo = repo
    @contract = contract
  end

  def all
    @repo.all
  end

  def build(attributes = {})
    @repo.build(attributes)
  end

  def create(input)
    values = yield validate(input)
    project = yield persist(values)

    Success(project)
  end

  def find(id)
    @repo.by_id(id)
  end

  private

  def validate(input)
    result = @contract.(input)
    if result.success?
      Success(result.values.to_h)
    else
      Failure(project: build(result.values.to_h), errors: result.errors)
    end
  end

  def persist(project, values = nil)
    values, project = project, nil if values.nil?

    if project
      Success(@repo.update(project.id, values))
    else
      Success(@repo.create(values))
    end
  end
end
