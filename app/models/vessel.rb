class Vessel < ApplicationRecord
  attr_accessor :city

  mount_uploader :photo, PhotoUploader

  belongs_to :user

  has_many :bookings
  has_many :reviews

  has_many :vessel_options
  has_many :options, through: :vessel_options

  enum category: [ :frigate, :galiot, :guineaman, :shipoftheline ]

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :photo, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :rating, inclusion: { in: [0, 1, 2 , 3, 4, 5, nil] }
  validates :category, presence: true

end
