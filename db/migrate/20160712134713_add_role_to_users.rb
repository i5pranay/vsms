class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: :customer, null: false, limit: 40
  end
end
