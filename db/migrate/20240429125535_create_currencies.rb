class CreateCurrencies < ActiveRecord::Migration[7.1]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :symbol
      t.string :stage
      t.integer :followers_count, default: 0
      t.integer :network_id

      t.timestamps
    end
    add_index :currencies, :symbol
    add_index :currencies, :network_id
  end
end
