class CreateCrews < ActiveRecord::Migration[5.2]
  def change
    create_table :crews do |t|
      t.string :name
      t.text :description
      t.date :availability
      t.integer :rating

      t.timestamps
    end
  end
end
