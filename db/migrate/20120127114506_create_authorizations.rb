class CreateAuthorizations < ActiveRecord::Migration
  def up
    create_table :authorizations do |t|
      t.string :code
      t.text :properties
      t.integer :created_by_api_key_id
      t.timestamps
    end

    add_index :authorizations, :code
  end

  def down
    drop_table :authorizations
  end
end
