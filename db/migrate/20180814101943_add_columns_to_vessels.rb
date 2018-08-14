class AddColumnsToVessels < ActiveRecord::Migration[5.2]
  def change
    add_column :vessels, :photo, :string
    add_column :vessels, :lat, :float
    add_column :vessels, :lng, :float
  end
end
