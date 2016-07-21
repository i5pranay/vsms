class AddServiceTypeIdToServiceCentre < ActiveRecord::Migration
  def change
    add_column :service_centres, :service_type_id, :integer,  null: false

  end
end
