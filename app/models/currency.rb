class Currency < ApplicationRecord
  #belongs_to :network
  has_one_attached :whitepaper
  has_one_attached :logo

  validates :symbol, uniqueness: true
end
