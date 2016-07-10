class CreateAddons < ActiveRecord::Migration
  def change
    create_table :addons do |t|

      t.string :part_name, null: true
      t.integer :part_cost, null: true
      t.string :model, null: false
      t.string :brand, null: false


      t.timestamps null: false
    end
  end
end
