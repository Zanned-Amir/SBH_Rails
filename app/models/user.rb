# app/models/user.rb

class User < ApplicationRecord
  has_many :orders , dependent: :nullify
  has_many :reviews ,dependent: :nullify
  has_many :user_roles
  has_many :order_details, through: :orders
  has_many :roles, through: :user_roles

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { message: "has already been taken" }
  validates :password, presence: true
  validates :state, presence: true

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
end

