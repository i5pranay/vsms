class Customer < ActiveRecord::Base
  has_many :vehicles
  has_many :service_requests


end
