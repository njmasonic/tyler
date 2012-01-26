class CreateTokens < ActiveRecord::Migration
  def up
    create_table :tokens do |t|
      t.string :token
      t.integer :user_id
      t.timestamps
    end

    add_index :tokens, :token
  end

  def down
    drop_table :tokens
  end
end
