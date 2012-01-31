class AddUserIdToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :user_id, :integer
    add_index :authorizations, :user_id
  end
end
