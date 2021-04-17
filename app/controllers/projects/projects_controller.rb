module Projects
  class ProjectsController < ApplicationController
    def new
      @project = repo.build
    end

    def create
      repo.create(project_params)

      redirect_to projects_projects_path, notice: 'Project has been created'
    end

    private

    def project_params
      params.require(:project).permit(:name).to_h.symbolize_keys
    end

    def repo
      @repo ||= ProjectRepository.new(rom)
    end
  end
end
