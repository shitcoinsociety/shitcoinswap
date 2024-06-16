class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :symbol
      t.string :stage
      t.string :repository_url
      t.integer :followers_count, default: 0

      t.timestamps
    end
    add_index :projects, :symbol
  end
end
