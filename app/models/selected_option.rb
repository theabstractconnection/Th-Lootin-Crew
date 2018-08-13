class SelectedOption < ApplicationRecord
  belongs_to :booking
  belongs_to :option

  validates :booking, presence: true
  validates :option, presence: true
end
