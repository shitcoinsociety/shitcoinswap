class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by(symbol: params[:symbol]) || Project.find(params[:id])
  end
end
