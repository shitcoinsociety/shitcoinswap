class Trade < ApplicationRecord
  belongs_to :buying_user, class_name: "User"
  belongs_to :selling_user, class_name: "User"
  belongs_to :buy_order, class_name: "Order", optional: true
  belongs_to :sell_order, class_name: "Order", optional: true

  scope :bought, -> (symbol) { where(buy_symbol: symbol)}
  scope :sold, -> (symbol) { where(sell_symbol: symbol)}
end
