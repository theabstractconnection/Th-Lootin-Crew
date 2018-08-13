class CreateVesselOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :vessel_options do |t|
      t.references :vessel, foreign_key: true
      t.references :option, foreign_key: true

      t.timestamps
    end
  end
end
