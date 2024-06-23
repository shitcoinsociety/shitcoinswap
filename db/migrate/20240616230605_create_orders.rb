class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|

      t.string :sell_symbol
      t.decimal :sell_amount
      t.decimal :remaining_sell_amount
      t.string :buy_symbol
      t.decimal :buy_amount
      t.decimal :remaining_buy_amount
      t.integer :user_id
      t.boolean :completed, default: false

      t.decimal :price, comment: "buy_amount / sell_amount"

      t.timestamps

      t.index :user_id
      # t.index :sell_symbol
      # t.index :buy_symbol
      t.index :sell_amount
      t.index :buy_amount
      t.index :price
      t.index [:sell_symbol, :buy_symbol]
    end
  end
end
