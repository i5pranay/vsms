class AddVehicleIdToServiceCentre < ActiveRecord::Migration
  def change
    add_column :service_centres, :vehicle_id, :integer,  null: false

  end
end
