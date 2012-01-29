class CreateApiKeys < ActiveRecord::Migration
  def up
    create_table :api_keys do |t|
      t.string :key
      t.timestamps
    end

    add_index :api_keys, :key
  end

  def down
    drop_table :api_keys
  end
end
