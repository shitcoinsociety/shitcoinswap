class PortfoliosController < ApplicationController
  before_action :require_user!
  
  def index
    @title = "My Portfolio"
  end
end
