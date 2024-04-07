class Product < ApplicationRecord
  belongs_to :category, touch: true
  has_many :order_details
  has_many :reviews
  has_one_attached :image

  validates :stock_quantity ,  numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["active", "category_id", "created_at", "description", "name", "price", "stock_quantity", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["category", "image_attachment", "image_blob", "order_details", "reviews"]
  end
end
