class DropRolePermissions < ActiveRecord::Migration[7.1]
  def change
    drop_table :role_Permissions
  end
end
