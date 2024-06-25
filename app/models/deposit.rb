class Deposit < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  after_create_commit :broadcast_balances
  after_destroy_commit :broadcast_balances

  def broadcast_balances
    user.broadcast_balances
  end
end
