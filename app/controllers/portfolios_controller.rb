class PortfoliosController < ApplicationController
  before_action :require_user!
  def show

    @title = "My Portfolio"
  end
end
