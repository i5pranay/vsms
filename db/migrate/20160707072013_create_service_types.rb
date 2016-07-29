class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types do |t|

      t.string :service_name, null: false
      t.integer :service_cost, null: false
      t.text :serv_desc, null: false

      t.timestamps null: false
    end
  end
end