class Vessel < ApplicationRecord
  belongs_to :user
  has_many :options, through: :vessel_option


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
