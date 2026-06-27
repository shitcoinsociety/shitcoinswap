class Account < ApplicationRecord
  # TODO: these shouldnt be optional, we just don't have the models yet
  belongs_to :user, optional: true
  belongs_to :asset, optional: true

  has_many :orders, dependent: :destroy

  attribute :balance, :decimal

  def available_balance
    balance - orders.active.sum(:funded_amount)
  end
end
