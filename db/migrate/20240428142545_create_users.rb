class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :name
      t.string :email
      t.string :password_digest
      t.timestamp :email_verified_at

      t.timestamps
    end

    add_index :users, :nickname, unique: true
    add_index :users, :email
  end
end
