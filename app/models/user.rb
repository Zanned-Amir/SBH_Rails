# app/models/user.rb

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders , dependent: :nullify
  has_many :reviews ,dependent: :nullify
  has_many :user_roles
  has_many :order_details, through: :orders
  has_many :roles, through: :user_roles

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { message: "has already been taken" } 
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :birth_date , presence: true 
  validates :state, presence: true
  validate :at_least_18_years_old

  def at_least_18_years_old
    if birth_date.present? && birth_date > 18.years.ago
      errors.add(:birth_date, 'You must be 18 years old or older.')
    end
  end

  TUNISIAN_STATES = [
    "Ariana",
    "Beja",
    "Ben Arous",
    "Bizerte",
    "Gabes",
    "Gafsa",
    "Jendouba",
    "Kairouan",
    "Kasserine",
    "Kebili",
    "Kef",
    "Mahdia",
    "Manouba",
    "Medenine",
    "Monastir",
    "Nabeul",
    "Sfax",
    "Sidi Bouzid",
    "Siliana",
    "Sousse",
    "Tataouine",
    "Tozeur",
    "Tunis",
    "Zaghouan"
  ].freeze
  GENDER_OPTIONS = ["Male", "Female"].freeze


  def self.ransackable_attributes(auth_object = nil)
    ["address_1", "address_2", "birth_date", "confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "email", "encrypted_password", "failed_attempts", "gender", "id", "id_value", "last_name", "locked_at", "name", "registration_date", "remember_created_at", "reset_password_sent_at", "reset_password_token", "state", "unconfirmed_email", "unlock_token", "updated_at"]
  end
end

