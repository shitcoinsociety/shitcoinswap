class Order < ApplicationRecord
  belongs_to :user
  belongs_to :have_project, class_name: "Project", foreign_key: "have_symbol", primary_key: "symbol", optional: true
  belongs_to :want_project, class_name: "Project", foreign_key: "want_symbol", primary_key: "symbol", optional: true

  before_validation :set_price

  validates :have_symbol, :want_symbol, :have_amount, :want_amount, presence: true
  validates :price, numericality: { greater_than: 0, greater_than_or_equal_to: 0.00000001 }
  validates :want_amount, numericality: { greater_than: 0, greater_than_or_equal_to: 0.00000001 }
  validates :have_amount, numericality: { greater_than: 0, greater_than_or_equal_to: 0.00000001 }

  validate :validate_sufficient_funds, on: :create

  def set_price
    self.price = want_amount / have_amount
  end

  def matches
    Order.where(have_symbol: want_symbol, want_symbol: have_symbol).where("price <= ?", 1.0 / price)
  end

  def validate_sufficient_funds
    return if user.available_balance(have_symbol) >= have_amount
    errors.add(:have_amount, "insufficient funds")
  end

  def fulfill!
    self.lock!
    matches.each do |o|
      o.lock!
      match!(o)
      break if self.want_amount <= 0 || self.have_amount <= 0
    end
  end

  def match!(other)
    amount_affordable = have_amount / other.price
    amount = [amount_affordable, want_amount, other.have_amount].min

    other.have_amount -= amount
    other.want_amount -= amount * other.price

    # order completely fulfilled
    if other.want_amount <= 0 || other.have_amount <= 0
      other.destroy!
    # order partially fulfilled
    else
      other.save!
    end

    self.want_amount -= amount
    self.have_amount -= amount * other.price

    # order completely fulfilled
    if self.want_amount <= 0 || self.have_amount <= 0
      self.destroy!
    # order partially fulfilled
    else
      self.save!
    end
  end
end
