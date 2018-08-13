class SelectedOption < ApplicationRecord
  belongs_to :booking
  belongs_to :option

  validates :booking, presence: true
  validates :option, presence: true

   delegate :name, to: :options
   delegate :description, to: :options
   delegate :price, to: :options
end
