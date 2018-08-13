class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vessel
  belongs_to :crew, optional: true

  has_many :selected_options, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
end
