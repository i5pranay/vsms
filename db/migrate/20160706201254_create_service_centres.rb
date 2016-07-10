class CreateServiceCentres < ActiveRecord::Migration
  def change
    create_table :service_centres do |t|
      t.string :name, null: false, limit: 100
      t.text :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :pincode, null: false
      t.integer :contact, null: false
      t.string :email, limit: 200, null: false

      t.timestamps null: false
    end
  end
end
