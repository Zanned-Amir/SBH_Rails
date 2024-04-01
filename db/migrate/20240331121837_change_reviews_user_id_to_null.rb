class ChangeReviewsUserIdToNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :reviews, :user_id, true
  end
end