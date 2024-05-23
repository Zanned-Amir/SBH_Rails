class Permissions < ActiveRecord::Migration[7.1]
  def change
    drop_table :permissions
  end
end
