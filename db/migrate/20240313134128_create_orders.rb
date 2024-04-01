class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :order_date
      t.decimal :total_amount
      t.string :status

      t.timestamps
    end
  end
end
