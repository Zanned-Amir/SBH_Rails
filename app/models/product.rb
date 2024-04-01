class Product < ApplicationRecord
  belongs_to :category, touch: true
  has_many :order_details
  has_many :reviews
end
