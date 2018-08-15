class AddColumnsToVessels < ActiveRecord::Migration[5.2]
  def change
    add_column :vessels, :photo, :string
    add_column :vessels, :latitude, :float
    add_column :vessels, :longitude, :float
    add_column :vessels, :address, :string
  end
end
