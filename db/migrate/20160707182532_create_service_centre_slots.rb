class CreateServiceCentreSlots < ActiveRecord::Migration
  def change
    create_table :service_centre_slots do |t|
      t.integer :service_centre_id, null: false
      t.time :slot_start_time, null: false
      t.time :slot_end_time, null: false

      t.timestamps null: false
    end
  end
end
