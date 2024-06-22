class Project < ApplicationRecord
  #belongs_to :network
  has_one_attached :whitepaper
  has_one_attached :logo

  has_many :sell_orders, class_name: "Order", foreign_key: "have_symbol", primary_key: "symbol"
  has_many :buy_orders, class_name: "Order", foreign_key: "want_symbol", primary_key: "symbol"

  before_validation :downcase_symbol

  validates :symbol, uniqueness: true

  def downcase_symbol
    self.symbol = symbol.try(:downcase)
  end
end
