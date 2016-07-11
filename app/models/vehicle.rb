class Vehicle < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :service_requests

end
