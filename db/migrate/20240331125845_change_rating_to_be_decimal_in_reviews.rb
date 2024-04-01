class ChangeRatingToBeDecimalInReviews < ActiveRecord::Migration[7.1]
  def change
    change_column :reviews, :rating, :decimal, precision: 2, scale: 2
  end
end