class CreateVesselOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :vessel_options do |t|
      t.references :vessel
      t.references :option

      t.timestamps
    end
  end
end
