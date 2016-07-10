class ServiceType < ActiveRecord::Base
  has_many :service_requests
end
