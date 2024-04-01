class Role < ApplicationRecord
    has_many :role_permissions
    has_many :permissions, through: :role_permissions
    has_many :user_roles
    has_many :users, through: :user_roles
  
    validates :name, presence: true, length: { maximum: 50 }
  end