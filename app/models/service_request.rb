class ServiceRequest < ActiveRecord::Base
  belongs_to :customer
  belongs_to :service_centre
  belongs_to :service_type
  belongs_to :service_centre_slot
  belongs_to :vehicle

  enum state: [ :created, :in_process, :completed ]
end
