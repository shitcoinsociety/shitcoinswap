class CurrenciesController < ApplicationController
  def index
    @currencies = Currency.all
  end

  def show
    @currency = Currency.find_by(symbol: params[:symbol]) || Currency.find(params[:id])
  end
end
