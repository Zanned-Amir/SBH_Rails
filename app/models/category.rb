class Category < ApplicationRecord
  has_many :products, dependent: :destroy
    validates :name, presence: true , uniqueness: { message: "%{value} has already been taken" }
  end
