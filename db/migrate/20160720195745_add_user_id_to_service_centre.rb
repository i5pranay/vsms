class AddUserIdToServiceCentre < ActiveRecord::Migration
  def change

    add_column :service_centres, :user_id, :integer,  null: false


  end
end
