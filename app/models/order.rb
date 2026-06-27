class Order < ApplicationRecord
  belongs_to :account

  attribute :sell_amount, :decimal
  attribute :buy_amount, :decimal
  attribute :remaining_sell_amount, :decimal

  validates :sell_asset_id, :buy_asset_id, presence: true

  validates :buy_amount, numericality: { greater_than: 0 }, allow_nil: true
  validates :sell_amount, numericality: { greater_than: 0 }
  validates :remaining_sell_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :funded_amount, numericality: { greater_than_or_equal_to: 0 }

  scope :completed, -> { where(completed: true) }
  scope :cancelled, -> { where.not(cancelled_at: nil) }
  scope :active, -> { where(completed: false, cancelled_at: nil) }

  default_scope { order("price desc, sell_amount desc") }

  after_create_commit :fund_and_process!

  def initialize(*)
    super
    self.sell_amount = self.sell_amount.try(:to_d)
    self.buy_amount = self.buy_amount.try(:to_d)
    self.remaining_sell_amount = self.sell_amount
    self.price = rational_price
  end

  # we don't use the price field from the database directly.
  # instead, we use rational_price to avoid floating point precision issues.
  def price
    rational_price
  end

  def rational_price
    if buy_amount && buy_amount > 0
      sell_amount.to_r / buy_amount.to_r
    else
      nil
    end
  end

  def fund_and_process!
    return if completed?
    fund!
    process!
  end

  def fund!
    available_amount = account.available_balance
    self.funded_amount = [ available_amount, sell_amount ].min
    save!
  end

  def process!
    self.lock!
    matching.lock.each do |other|
      match!(other)
      break if completed?
    end
  end

  def matching
    # an order matches if the buy_asset_id of this order is the sell_asset_id of another order and vice versa
    result = Order.active.where(sell_asset_id: buy_asset_id, buy_asset_id: sell_asset_id)

    if price
      # if we have a price, we don't want to match with orders with a price higher than ours
      result = result.where("price IS NULL OR price >= ?", 1.0 / price)
    end

    result
  end

  def match!(other)
    return if completed? || remaining_sell_amount <= 0 || funded_amount <= 0

    # first, we have to determine the agreed-upon price
    if other.price
      price = [ self.price, 1.0.to_r / other.price ].compact.min
    elsif self.price
      price = self.price
    else
      # both orders are market orders — can't determine a fair rate, skip
      return
    end

    # calculate how much of the buy_asset can we afford at the price
    amount_affordable = funded_amount.to_r / price

    # determine the amount to trade, which is the minimum of what we can afford and what the other order has funded
    amount = [
      amount_affordable,
      other.funded_amount.to_r
    ].compact.min.to_r

    return unless amount > 0

    self.remaining_sell_amount -= price * amount
    self.funded_amount -= price * amount

    other.remaining_sell_amount -= amount
    other.funded_amount -= amount

    # TODO: update the accounts of both users to reflect the trade

    self.completed = true if remaining_sell_amount <= 0
    other.completed = true if other.remaining_sell_amount <= 0

    [ other, self ].each(&:save!)
  end
end
