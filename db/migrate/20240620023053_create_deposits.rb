class CreateDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits do |t|
      t.string :symbol
      t.integer :user_id
      t.decimal :amount
      t.string :gateway
      t.string :gateway_id
      t.integer :confirmations

      t.timestamps

      t.index :symbol
      t.index :user_id
      t.index :gateway_id
    end
  end
end
