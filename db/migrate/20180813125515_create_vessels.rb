  class CreateVessels < ActiveRecord::Migration[5.2]
  def change
    create_table :vessels do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :user

      t.timestamps
    end
  end
end
