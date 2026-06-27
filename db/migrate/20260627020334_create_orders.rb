class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.integer :account_id, null: false
      t.string :sell_asset_id, null: false, default: "usd"
      t.string :buy_asset_id, null: false, default: "btc"
      t.decimal :buy_amount, default: '0', null: false, precision: 36, scale: 18, comment: "min amount of buy_asset to receive"
      t.decimal :sell_amount, null: false, precision: 36, scale: 18, comment: "amount of sell_asset to sell"
      t.decimal :funded_amount, default: '0', null: false, precision: 36, scale: 18, comment: "amount of sell_asset funded"

      t.decimal :remaining_sell_amount, null: false, precision: 36, scale: 18

      t.boolean :completed, default: false, null: false
      t.timestamp :cancelled_at

      t.decimal :price, comment: "sell_amount / buy_amount", precision: 36, scale: 18

      t.timestamps

      t.index :account_id
      t.index :price
      t.index [ :sell_asset_id, :buy_asset_id ]
      t.index [ :completed, :cancelled_at ]
      t.index [ :account_id, :completed ]
      t.index [ :account_id, :cancelled_at ]
      t.index :created_at
    end
  end
end
