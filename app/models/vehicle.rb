class Vehicle < ActiveRecord::Base
  belongs_to :owner, class_name: Customer
  has_many :service_requests

end
