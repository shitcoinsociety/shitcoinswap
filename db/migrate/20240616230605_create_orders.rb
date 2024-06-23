class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|

      t.string :have_symbol
      t.decimal :have_amount
      t.decimal :remaining_have_amount
      t.string :want_symbol
      t.decimal :want_amount
      t.decimal :remaining_want_amount
      t.integer :user_id
      t.boolean :completed, default: false

      t.decimal :price, comment: "want_amount / have_amount"

      t.timestamps

      t.index :user_id
      # t.index :have_symbol
      # t.index :want_symbol
      t.index :have_amount
      t.index :want_amount
      t.index :price
      t.index [:have_symbol, :want_symbol]
    end
  end
end
