class Order < ApplicationRecord
  belongs_to :user
  belongs_to :have_project, class_name: "Project", foreign_key: "have_symbol", primary_key: "symbol", optional: true
  belongs_to :want_project, class_name: "Project", foreign_key: "want_symbol", primary_key: "symbol", optional: true


  validates :have_symbol, :want_symbol, :have_amount, :want_amount, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :want_amount, numericality: { greater_than: 0 }
  validates :have_amount, numericality: { greater_than: 0 }
  validates :remaining_have_amount, :remaining_want_amount, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_sufficient_funds, on: :create

  before_validation :set_price, on: :create
  before_validation :set_amounts, on: :create

  scope :open, -> { where(completed: false) }

  def set_price
    self.price = want_amount / have_amount
  end

  def set_amounts
    self.remaining_have_amount = self.have_amount
    self.remaining_want_amount = self.want_amount
  end

  def matches
    Order.open.where(have_symbol: want_symbol, want_symbol: have_symbol).where("price <= ?", 1.0 / price).order('price asc')
  end

  def validate_sufficient_funds
    return if user.available_balance(have_symbol) >= have_amount
    errors.add(:have_amount, "insufficient funds")
  end

  def process!
    return if completed?
    self.lock!
    matches.lock.each do |o|
      match!(o)
      break if completed?
    end
  end

  def match!(other)
    amount_affordable = remaining_have_amount / other.price
    amount = [amount_affordable, remaining_want_amount, other.remaining_have_amount].min

    other.remaining_have_amount -= amount
    other.remaining_want_amount -= amount * other.price
    other.completed = other.remaining_want_amount <= 0

    self.remaining_want_amount -= amount
    self.remaining_have_amount -= amount * other.price
    self.completed = self.remaining_want_amount <= 0

    other.save!
    self.save!

  end
end
