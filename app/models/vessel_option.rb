class VesselOption < ApplicationRecord
  belongs_to :option
  belongs_to :vessel

  # validates :option, uniqueness: true
end
