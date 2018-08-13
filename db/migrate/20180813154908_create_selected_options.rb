class CreateSelectedOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :selected_options do |t|
      t.integer :quantity
      t.references :booking, foreign_key: true
      t.references :option, foreign_key: true

      t.timestamps
    end
  end
end
