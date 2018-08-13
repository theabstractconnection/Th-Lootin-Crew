class Vessel < ApplicationRecord
  belongs_to :user

  has_many :bookings

  has_many :vessel_options
  has_many :options, through: :vessel_options


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
