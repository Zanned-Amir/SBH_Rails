class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true , reject_if: :all_blank

  enum status: { pending: 'Pending', confirmed: 'Confirmed', shipped: 'Shipped', delivered: 'Delivered' ,Cancelled: 'Cancelled' }

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end