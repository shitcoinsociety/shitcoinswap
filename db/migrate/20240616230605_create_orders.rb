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
      t.boolean :completed, default: false, null: false
      t.boolean :cancelled, default: false, null: false

      t.decimal :price, comment: "buy_amount / sell_amount"

      t.timestamps

      t.index :user_id
      t.index :price
      t.index [:sell_symbol, :buy_symbol]
      t.index [:completed, :cancelled]
      t.index [:user_id, :completed]
      t.index [:user_id, :cancelled]
      t.index :created_at
    end
  end
end
