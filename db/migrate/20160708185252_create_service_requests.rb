class CreateServiceRequests < ActiveRecord::Migration
  def change
    create_table :service_requests do |t|

      t.integer :service_centre_id, null: false
      t.integer :user_id, null: false
      t.integer :vehicle_id, null: false
      t.integer :service_type_id, null: false
      t.string :state, null: false
      t.float :estimated_bill, default: 0
      t.float :actual_bill, default: 0
      t.integer :service_centre_slot_id, null: false




      t.timestamps null: false
    end
  end
end
