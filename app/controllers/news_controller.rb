class NewsController < ApplicationController
  def index
  end

  def show
    @slug = params[:id]
  end
end
