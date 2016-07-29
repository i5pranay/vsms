class AdminpanelsController < ApplicationController
  include NavigationsHelper

  def new_sc_details
    #this will send controll to service_centre_details

    #show details of service centre
    @collect_service_centre = []
    @service_centres =  ServiceCentre.where(owner_id: current_user.id).all

    @service_centres.each do|sc|
      @collect_service_centre << sc
    end


  end

  def edit_sc_details
  centre_id =params[:centre_id]
    @centre_details = ServiceCentre.where(id: centre_id).first

  end

   def update_edit_sc_details
     centre_id = params[:centre][:centre_id]
     name=params[:centre][:name]
     email= params[:centre][:email]
     address=params[:centre][:address]
     contact=params[:centre][:contact]
     city=params[:centre][:city]
     pincode=params[:centre][:pincode]
     state=params[:centre][:state]

     ServiceCentre.where(id: centre_id).update_all(name: name , email: email, address: address, contact: contact, city: city, pincode: pincode,state: state )
     redirect_to new_sc_details_path, flash: {notice: "centre successfully updated"}

   end

  def destroy_sc_detail
    centre_id = params[:centre_id]
    centre_to_delete = ServiceCentre.where(id: centre_id).first
   if centre_to_delete.destroy
     @is_deleted = true
   else
     @is_deleted = false
   end
   end






  def new_service_slots
    @service_centre_by_id ={}
    service_centre_ids =[]
    @service_centres = ServiceCentre.where(owner_id: current_user.id).all
    @service_centres.each do |s|
      service_centre_ids << s.id
      @service_centre_by_id[s.id] ||= s

    end

    @service_slots = ServiceCentreSlot.where(service_centre_id:service_centre_ids )

    # this will send controll to service_centre_details
  end



  def new_service_types
     #this will send controll to service_centre_details
    @centre_by_id ={}
    centre_ids =[]
    @service_centres = ServiceCentre.where(owner_id: current_user.id).all
    @service_centres.each do |s|
      centre_ids << s.id
      @centre_by_id[s.id] ||= s

    end
    @service_types = ServiceType.where(centre_id: centre_ids)
  end

  def create_sc_details

    persist_sc_details
    #redirect_to show_sc_details_url(:sc_id => persist_sc_details.id)

  end

  def create_service_slots
    persist_slots
    redirect_to new_services_slots_path, flash: {notice:  "slot created sucessfully!!"}
  end





  def create_service_types
    @service_type = ServiceType.new(s_type_params)
  #   todo handle error case
    @service_type.save

redirect_to new_services_types_path , flash: {notice: "service created sucessfully!!"}
   # redirect_to show_service_types_url(:st_id => @service_type.id)
  end

  #edit service types
  def edit_service_type_view
    service_type_id = params[:service_type_id]
    @service_type = ServiceType.where(id: service_type_id).first
    @service_centre = ServiceCentre.where(id: @service_type.centre_id).first



  end

   def edit_service_type
     service_type_id = params[:s_type][:service_type_id]
     service_name = params[:s_type][:service_name]
     service_cost = params[:s_type][:service_cost]
     service_desc = params[:s_type][:serv_desc]

     ServiceType.where(id: service_type_id).update_all(service_name: service_name,service_cost:service_cost,serv_desc:service_desc )

     redirect_to new_services_types_path, flash: {notice: " service type sucessfully updated!!"}

   end

  def destroy_service_type
   service_type_id = params[:service_type_id]
    service_type_to_delete = ServiceType.where(id: service_type_id).first
  if  service_type_to_delete.destroy
    @is_deleted = true
  else
    @is_deleted = false
  end



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


  def edit_service_slot_view

    slot_id = params[:slot_id]
    @slot_details = ServiceCentreSlot.select(:service_centre_id, :slot_start_time, :slot_end_time, :id).where(id: slot_id).first
    @service_centre = ServiceCentre.where(id: @slot_details.service_centre_id ).first


  end

  def edit_service_slot
    slot_id = params[:slot][:slot_id]
    start_time = params[:slot][:slot_start_time]
    end_time = params[:slot][:slot_end_time]

    ServiceCentreSlot.where(id: slot_id).update_all(slot_start_time: start_time , slot_end_time: end_time)

    redirect_to new_services_slots_path, flash: {notice: "slot successfully updated"}
  end
 #destroy service slot
  def destroy_service_slot
   slot_id = params[:slot_id]
   slot_to_delete = ServiceCentreSlot.where(id: slot_id).first
   if slot_to_delete.destroy
     @is_deleted = true
   else
     @is_deleted = false
   end

  end




  def list_admin_sr
    service_centres  = ServiceCentre.where(owner_id: current_user.id)
    # we have used where instead of find because where will return array of result and find returns only single result.

    service_centre_ids = []
    service_centres.each do |sc|
      service_centre_ids << sc.id
    end

    service_requests = ServiceRequest.where(service_centre_id: service_centre_ids)
    @final_data = get_detailed_info_for_service_requests(service_requests)

    #render json: @final_data
  end

   def update_service_request_view
     request_id = params[:request_id]
     service_requests = ServiceRequest.where(id: request_id)
     @sr_info = get_detailed_info_for_service_requests(service_requests).first
   end

   def update_service_request
     request_id = params[:sr][:id]
     cost = params[:sr][:actual_bill]
     state = params[:sr][:state]
      ServiceRequest.where(id: request_id).update_all(actual_bill: cost, state: state)



     redirect_to list_admin_sr_path ,flash: {notice: "request updated sucessfully!!"}
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
    params.require(:centre).permit(:name, :email, :address, :city, :state, :pincode, :contact, :owner_id)
  end

  def slot_params
    params.require(:slot).permit(:service_centre_id, :slot_start_time, :slot_end_time)
  end

  def s_type_params
    params.require(:s_type).permit(:service_name, :service_cost, :serv_desc, :centre_id)
  end

  def sr_params
    params.require(:sr).permit(:state, :actual_bill, :id)
  end
end
