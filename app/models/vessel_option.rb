class VesselOption < ApplicationRecord
  has_many :options
  has_many :vessels
end
