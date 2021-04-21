require 'dry/monads'
require 'dry/monads/do'

class ProjectsContext
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:create)

  delegate :all, :build, :find, to: :@repo

  def initialize(repo = ProjectRepository.new(ROM.env), contract = ProjectContract.new)
    @repo = repo
    @contract = contract
  end

  def create(input)
    values = yield validate(input)
    project = yield persist(values)

    Success(project)
  end

  def update(project, input)
    values = yield validate(input)
    project = yield persist(project, values)

    Success(project)
  end

  def destroy(project)
    project = @repo.delete(project.id)

    case project
    when Entities::Project
      Success(project)
    else
      Failure()
    end
  end

  private

  def validate(input)
    result = @contract.call(input)
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
