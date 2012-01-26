class CreateConsumers < ActiveRecord::Migration
  def up
    create_table :consumers do |t|
      t.string :name
      t.string :return_url
      t.timestamps
    end
  end

  def down
    drop_table :consumers
  end
end
