class AddServiceCentreSlotIdToServiceCentre < ActiveRecord::Migration
  def change
    add_column :service_centres, :service_centre_slot_id, :integer,  null: false

  end
end
