class SelectedOption < ApplicationRecord
  belongs_to :booking
  belongs_to :option

  delegate :name, to: :option
  delegate :description, to: :option
  delegate :price, to: :option
end
