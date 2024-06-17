class Order < ApplicationRecord
  belongs_to :user

  def funded?
    user.balances[have_symbol] >= have_amount
  end
end
