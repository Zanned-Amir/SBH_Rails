class AddUsernameToAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :username, :string
  end
end
