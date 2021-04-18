class ProjectsController < ApplicationController
  def index
    @projects = repo.all
  end

  def show
    @project = repo.by_id(params[:id])
  end

  def new
    @project = repo.build
  end

  def create
    case project_contract.(project_params)
    in Dry::Validation::Result => result if result.success?
      repo.create(project_params)
      redirect_to projects_path, notice: 'Project has been created'
    in Dry::Validation::Result => result
      @errors = result.errors
      @project = repo.build
      flash.now[:alert] = 'Project could not be created'
      render :new
    end
  end

  private

  def project_contract
    @project_contract ||= ProjectContract.new
  end

  def project_params
    params.require(:project).permit(:name).to_h.symbolize_keys
  end

  def repo
    @repo ||= ProjectRepository.new(rom)
  end
end
