class Vehicle < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :service_requests


  def self.find_or_create_vehicle(hash)
    vehicle_number = hash[:vehicle][:number]
    existing_vehicle = Vehicle.where(number: vehicle_number).first
    if existing_vehicle.present?
      return existing_vehicle
    end

    strong_vehicle_params = vehicle_params(hash)

    vehicle = Vehicle.new(strong_vehicle_params)
    vehicle.save
    vehicle
  end

  private
  def self.vehicle_params(params)
    params.require(:vehicle).permit(:vehicle_type, :model, :number, :owner_name, :year, :user_id)
  end
end
