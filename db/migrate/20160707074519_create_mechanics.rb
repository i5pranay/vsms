class CreateMechanics < ActiveRecord::Migration
  def change
    create_table :mechanics do |t|
      t.string :name, limit: 200, null: false
      t.string :email_id, limit: 200, null:false
      t.text :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :pincode, null: false
      t.string :gender, null: true
      t.integer :contact, null: true
      t.integer :service_centre_id, null: false

      t.timestamps null: false
    end
  end
end
