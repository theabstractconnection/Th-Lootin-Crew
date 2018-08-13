class Crew < ApplicationRecord
  has_many :booking

  validates :name, presence: true
  validates :description, presence: true
  validates :availability, presence: true
  validates :rating, presence: true, inclusion: { in: (0..4).to_a}
end
