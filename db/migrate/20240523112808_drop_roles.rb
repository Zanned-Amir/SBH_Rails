class DropRoles < ActiveRecord::Migration[7.1]
  def change
    drop_table :roles
  end
end
