class Deposit < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
