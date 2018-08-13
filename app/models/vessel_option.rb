class VesselOption < ApplicationRecord
  belongs_to :option
  belongs_to :vessel

  validates :option, presence: true
  validates :vessel, presence: true
end
