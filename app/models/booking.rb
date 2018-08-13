class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vessel
  has_many :selected_options

  validates :user, presence: true
  validates :vessel, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
