class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by(symbol: params[:symbol].try(:downcase)) || Project.find(params[:id])
    @title = @project.name
    @sell_orders = @project.sell_orders.order('price asc')
    @buy_orders = @project.buy_orders.order('price desc')
  end
end
