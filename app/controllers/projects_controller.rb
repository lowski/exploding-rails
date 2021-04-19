class ProjectsController < ApplicationController
  def index
    render :index, locals: { projects: context.all }
  end

  def show
    render :show, locals: { project: context.find(params[:id]) }
  end

  def new
    render :new, locals: { project: context.build }
  end

  def create
    case context.create(project_params)
    in Success(Entities::Project => project)
      redirect_to projects_path, notice: 'Project has been created'
    in Failure(errors: Dry::Validation::MessageSet => errors, project: Entities::Project => project)
      flash.now[:alert] = 'Project could not be created'
      render :new, locals: { errors: errors, project: project }
    end
  end

  private

  def context
    @context ||= ProjectContext.new(ProjectRepository.new(rom), ProjectContract.new)
  end

  def project_params
    params.require(:project).permit(:name).to_h.symbolize_keys
  end
end
