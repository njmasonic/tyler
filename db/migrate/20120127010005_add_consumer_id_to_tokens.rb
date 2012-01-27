class AddConsumerIdToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :consumer_id, :integer
    add_index  :tokens, [:consumer_id, :user_id]
  end
end
