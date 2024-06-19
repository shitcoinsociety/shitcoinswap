class Project < ApplicationRecord
  #belongs_to :network
  has_one_attached :whitepaper
  has_one_attached :logo

  validates :symbol, uniqueness: true

  has_many :sell_orders, foreign_key: "have_symbol", primary_key: "symbol"
  has_many :buy_orders, foreign_key: "want_symbol", primary_key: "symbol"

end
