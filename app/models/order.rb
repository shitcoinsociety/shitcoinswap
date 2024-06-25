class Order < ApplicationRecord
  VALID_PAIRS = [
    [:eur, :mnt]
  ]

  belongs_to :user
  belongs_to :have_project, class_name: "Project", foreign_key: "sell_symbol", primary_key: "symbol", optional: true
  belongs_to :want_project, class_name: "Project", foreign_key: "buy_symbol", primary_key: "symbol", optional: true


  validates :sell_symbol, :buy_symbol, :sell_amount, :buy_amount, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :buy_amount, numericality: { greater_than: 0 }
  validates :sell_amount, numericality: { greater_than: 0 }
  validates :remaining_sell_amount, :remaining_buy_amount, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_sufficient_funds, on: :create
  validate :validate_supported_trading_pair

  before_validation :set_price, on: :create
  before_validation :set_amounts, on: :create

  scope :open, -> { where(completed: false) }

  def set_price
    self.price = rational_price
  end

  def rational_price
    buy_amount.to_r / sell_amount.to_r
  end

  def set_amounts
    self.remaining_sell_amount = self.sell_amount
    self.remaining_buy_amount = self.buy_amount
  end

  def matches
    Order.open.where(sell_symbol: buy_symbol, buy_symbol: sell_symbol).where("price <= ?", 1.0 / price).order('price asc')
  end

  def validate_sufficient_funds
    return if user.available_balance(sell_symbol) >= sell_amount
    errors.add(:sell_amount, "insufficient funds")
  end

  def validate_supported_trading_pair
    return if VALID_PAIRS.include? [buy_symbol.to_sym, sell_symbol.to_sym]
    return if VALID_PAIRS.include? [sell_symbol.to_sym, buy_symbol.to_sym]
    errors.add(:base, "unsupported trading pair")
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
    price = other.rational_price
    amount_affordable = remaining_sell_amount.to_r / price
    amount = [amount_affordable, remaining_buy_amount, other.remaining_sell_amount].min.to_r

    other.remaining_sell_amount -= amount
    other.remaining_buy_amount -= price * amount
    other.completed = other.remaining_buy_amount <= 0

    self.remaining_buy_amount -= amount
    self.remaining_sell_amount -= price * amount
    self.completed = self.remaining_buy_amount <= 0

    Trade.create!(
      buying_user: self.user,
      selling_user: other.user,
      buy_symbol: self.buy_symbol,
      sell_symbol: self.sell_symbol,
      buy_amount: amount,
      sell_amount: price * amount,
      price: price,
      buy_order: other,
      sell_order: self)

    other.save!
    self.save!
  end
end
