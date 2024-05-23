class DropUserRoles < ActiveRecord::Migration[7.1]
  def change
    drop_table :user_roles
  end
end
