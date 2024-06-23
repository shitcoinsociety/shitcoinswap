class OrdersController < ApplicationController
  def new
    @want = Project.find_by_symbol(params[:symbol])

  end

  def create
    @order = current_user.orders.create(
      buy_symbol: params[:symbol],
      buy_amount: params[:amount],
      sell_symbol: params[:sell_symbol],
      sell_amount: params[:sell_amount])
  end
end
