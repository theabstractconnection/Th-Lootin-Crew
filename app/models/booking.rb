class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vessel
  belongs_to :crew, optional: true

  has_many :selected_options, dependent: :destroy

  accepts_nested_attributes_for :selected_options

  validates :start_date, presence: true
  validates :end_date, presence: true
end
