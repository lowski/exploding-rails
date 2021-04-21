class ProjectsController < ApplicationController
  def index
    render :index, locals: { projects: projects.all }
  end

  def show
    render :show, locals: { project: projects.find(params[:id]) }
  end

  def new
    render :new, locals: { project: projects.build }
  end

  def create
    case projects.create(project_params)
    in Success(Entities::Project => project)
      redirect_to projects_path, notice: 'Project has been created'
    in Failure(errors: Dry::Validation::MessageSet => errors, project: Entities::Project => project)
      flash.now[:alert] = 'Project could not be created'
      render :new, locals: { errors: errors, project: project }
    end
  end

  private

  def projects
    @projects ||= ProjectsContext.new
  end

  def project_params
    params.require(:project).permit(:name).to_h.symbolize_keys
  end
end
