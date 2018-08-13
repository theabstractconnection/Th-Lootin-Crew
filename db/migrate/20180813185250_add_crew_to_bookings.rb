class AddCrewToBookings < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookings, :crew, foreign_key: true
  end
end
