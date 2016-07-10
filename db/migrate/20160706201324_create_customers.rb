class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name, limit: 100, null: false
      t.string :email_id, limit: 200, null:false
      t.text :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :pincode, null: false
      t.integer :contact_no, null: false

      t.timestamps null: false
    end
  end
end
