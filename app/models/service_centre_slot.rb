class ServiceCentreSlot < ActiveRecord::Base
  has_many :service_requests
  belongs_to :service_centre
end
