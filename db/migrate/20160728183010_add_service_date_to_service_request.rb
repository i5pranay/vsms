class AddServiceDateToServiceRequest < ActiveRecord::Migration
  def change

    add_column :service_requests, :service_date, :date,  null: false
  end
end
