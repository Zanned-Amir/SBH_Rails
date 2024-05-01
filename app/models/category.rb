class Category < ApplicationRecord
  has_many :products, dependent: :destroy
    validates :name, presence: true , uniqueness: { message: "%{value} has already been taken" }

    
    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "id_value", "name", "updated_at"]
    end
  end
