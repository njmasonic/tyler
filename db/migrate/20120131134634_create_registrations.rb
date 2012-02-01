class CreateRegistrations < ActiveRecord::Migration
  def up
    create_table :registrations do |t|
      t.integer :user_id
      t.integer :authorization_id
      t.string  :code
      t.text    :properties
    end
    add_index :registrations, :user_id
    add_index :registrations, :authorization_id
    remove_column :authorizations, :user_id
  end

  def down
    add_column :authorizations, :user_id
    add_index :authorizations, :user_id
    drop_table :registrations
  end
end
