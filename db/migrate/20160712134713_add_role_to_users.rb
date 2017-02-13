class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: :super_admin, null: false, limit: 40
  end
end
