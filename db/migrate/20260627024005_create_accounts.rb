class CreateAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :asset_id
      t.decimal :balance, precision: 36, scale: 18, default: '0', null: false

      t.timestamps
    end
  end
end
