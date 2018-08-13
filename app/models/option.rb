class Option < ApplicationRecord
  has_many :vessel_options

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
