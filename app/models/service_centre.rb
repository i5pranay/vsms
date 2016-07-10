class ServiceCentre < ActiveRecord::Base
  has_many :service_requests
  has_many :service_centre_slots
end
