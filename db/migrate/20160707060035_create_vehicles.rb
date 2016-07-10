class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|

      t.string :vehicle_type, limit: 100, null: false
      t.text :model, null: false
      t.string :number, null: false
      t.text :owner_name, null: false
      t.integer :year, null: false
       t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
