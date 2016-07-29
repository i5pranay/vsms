class AddCentreIdToServiceType < ActiveRecord::Migration
  def change
    add_column :service_types, :centre_id, :integer,  null: false

  end
end
