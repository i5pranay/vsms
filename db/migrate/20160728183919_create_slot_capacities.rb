class CreateSlotCapacities < ActiveRecord::Migration
  def change
    create_table :slot_capacities do |t|

      t.integer :service_centre_slot_id, null: false
      t.date :service_date, null: false
      t.integer :capacity_used, default: 1
      t.timestamps null: false
    end
  end
end
