class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :password
      t.datetime :registration_date
      t.string :address_1
      t.string :address_2
      t.string :state
      t.string :gender
      t.date :birth_date

      t.timestamps
    end
  end
end
