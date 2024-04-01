class ChangeScaleOfRatingInReviews < ActiveRecord::Migration[6.0]
  def change
    change_column :reviews, :rating, :decimal, precision: 3, scale: 2
  end
end
