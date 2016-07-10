class AdminpanelsController < ApplicationController

  def new_sc_details
    #this will send controll to service_centre_details
  end

  def new_service_slots
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
