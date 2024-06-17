class OrdersController < ApplicationController
  def new
    @want = Project.find_by_symbol(params[:symbol])
    
  end

  def create
    @order = current_user.orders.create(
      want_symbol: params[:symbol],
      want_amount: params[:amount],
      have_symbol: params[:have_symbol],
      have_amount: params[:have_amount])
  end
end
