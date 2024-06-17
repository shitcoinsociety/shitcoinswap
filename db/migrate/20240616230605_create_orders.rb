class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|

      t.string :have_symbol
      t.decimal :have_amount
      t.string :want_symbol
      t.decimal :want_amount
      t.integer :user_id

      t.timestamps
    end
  end
end
