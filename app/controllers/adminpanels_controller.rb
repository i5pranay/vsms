class AdminpanelsController < ApplicationController

  def new_sc_details
    #this will send controll to service_centre_details
  end

  def new_service_slots
    @service_centres = ServiceCentre.where(owner_id: current_user.id).all


     # this will send controll to service_centre_details
  end

  def new_service_types
     #this will send controll to service_centre_details
  end

  def create_sc_details

    redirect_to show_sc_details_url(:sc_id => persist_sc_details.id)
  end

  def create_service_slots

    redirect_to show_service_slots_url(:ss_id => persist_slots.id)
  end

  def create_service_types
    @service_type = ServiceType.new(s_type_params)
  #   todo handle error case
    @service_type.save

    redirect_to show_service_types_url(:st_id => @service_type.id)
  end

  def show_sc_details
    @sc_details = ServiceCentre.find(params[:sc_id])
  end

  def show_service_slots
    @service_slots = ServiceCentreSlot.find(params[:ss_id])
  end

  def show_service_types
    @service_types = ServiceType.find(params[:st_id])

  end

  def update_sc_details
    

  end

  def update_service_slots

  end

  def update_service_types

  end

  def list_admin_sr
    service_centres  = ServiceCentre.where(owner_id: current_user.id)
    # we have used where instead of find because where will return array of result and find returns only single result.


    service_centre_ids = []
    service_centres.each do |sc|
      service_centre_ids << sc.id
    end

    service_requests = ServiceRequest.where(service_centre_id: service_centre_ids)

    vehicle_ids = []
    service_types_ids = []
    service_centre_slots_ids = []
    user_ids = []
    vehicles = nil

    service_requests.each do |sr|
      vehicle_ids << sr.vehicle_id
      service_types_ids << sr.service_type_id
      service_centre_slots_ids << sr.service_centre_slot_id
      user_ids <<  sr.user_id
    end

    service_centre_by_id ={}
    if service_centre_ids.present?
    servicecentres = ServiceCentre.where(id: service_centre_ids )

    servicecentres.each do |v|
      service_centre_by_id[v.id] ||= v
      end
    end

    vehicles_by_id = {}
    if vehicle_ids.present?
      vehicles = Vehicle.where(id: vehicle_ids).all #.all is to be removed.
      # SELECT `vehicles`.* FROM `vehicles` WHERE `vehicles`.`id` IN (1, 2, 3)

      vehicles.each do |v|
        vehicles_by_id[v.id] ||= v

      end
    end

    service_types_by_id = {}
    if service_types_ids.present?
      service_types = ServiceType.where(id: service_types_ids)

      service_types.each do |v|
        service_types_by_id[v.id] ||= v
      end
    end

    users_by_id = {}
    if user_ids.present?
      users = User.where(id: user_ids)

      users.each do |v|
        users_by_id[v.id] ||= v
      end
    end

    @final_data = []
    service_requests.each do |sr|
      a= 10

      @final_data << {
          model: vehicles_by_id[sr.vehicle_id].model,
          request_date: sr.created_at.strftime("%Y %M %d, %I:%m"),
          state: sr.state,
          actual_bill: sr.actual_bill,
          estimated_bill: sr.estimated_bill,
          service_centre: service_centre_by_id[sr.service_centre_id].name,
          user: users_by_id[sr.user_id].name,
          service_type: service_types_by_id[sr.service_type_id].service_name,
          vehicle_number: vehicles_by_id[sr.vehicle_id].number
      }
    end
    a=1

    #render json: @final_data

  end


  private

  def persist_sc_details
    sc_detail=ServiceCentre.new(centre_params)
    # todo - handle all the error case
    sc_detail.save
    sc_detail
  end

  def persist_slots
    strong_slot_params = slot_params
    service_slot = ServiceCentreSlot.new(strong_slot_params)
    # todo - handle all the error case
    service_slot.save
    service_slot
  end

  def centre_params
    params.require(:centre).permit(:name, :email, :address, :city, :state, :pincode, :contact)
  end

  def slot_params
    params.require(:slot).permit(:service_centre_id, :slot_start_time, :slot_end_time)
  end

  def s_type_params
    params.require(:s_type).permit(:service_name, :service_cost, :serv_desc)
  end
end
