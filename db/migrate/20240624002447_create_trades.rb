class CreateTrades < ActiveRecord::Migration[7.1]
  def change
    create_table :trades do |t|
      t.integer :buying_user_id
      t.integer :selling_user_id
      t.string :buy_symbol
      t.string :sell_symbol
      t.decimal :buy_amount
      t.decimal :sell_amount
      t.decimal :price
      t.integer :buy_order_id
      t.integer :sell_order_id

      t.timestamps

      t.index :buying_user_id
      t.index :selling_user_id
      t.index :buy_symbol
      t.index :sell_symbol

      t.index [:buying_user_id, :buy_symbol]
      t.index [:selling_user_id, :sell_symbol]
      t.index [:buying_user_id, :sell_symbol]
      t.index [:selling_user_id, :buy_symbol]
    end
  end
end
