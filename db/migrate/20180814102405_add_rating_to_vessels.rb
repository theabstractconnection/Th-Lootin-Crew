class AddRatingToVessels < ActiveRecord::Migration[5.2]
  def change
    add_column :vessels, :rating, :integer
  end
end
