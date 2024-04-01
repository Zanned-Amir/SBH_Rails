class Review < ApplicationRecord
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :user_id, uniqueness: { scope: :product_id, message: "You have already reviewed this product" }
  belongs_to :user
  belongs_to :product
end
