class Order < ApplicationRecord
  belongs_to :user
  belongs_to :have_project, class_name: "Project", foreign_key: "have_symbol", primary_key: "symbol", optional: true
  belongs_to :want_project, class_name: "Project", foreign_key: "want_symbol", primary_key: "symbol", optional: true

  before_validation :set_price

  validates :have_symbol, :want_symbol, :have_amount, :want_amount, presence: true
  validates :price, numericality: { greater_than: 0, greater_than_or_equal_to: 0.00000001 }
  validates :want_amount, numericality: { greater_than: 0, greater_than_or_equal_to: 0.00000001 }
  validates :have_amount, numericality: { greater_than: 0, greater_than_or_equal_to: 0.00000001 }

  def funded?
    user.balances[have_symbol] >= have_amount
  end

  def set_price
    self.price = want_amount / have_amount
  end
end
