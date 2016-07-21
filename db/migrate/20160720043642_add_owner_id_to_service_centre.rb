class AddOwnerIdToServiceCentre < ActiveRecord::Migration
  def change
    add_column :service_centres, :owner_id, :integer,  null: false
  end
end
