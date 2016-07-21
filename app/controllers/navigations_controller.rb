class NavigationsController < ApplicationController
  before_filter :authenticate_user! , except: [:get_slots_by_service_centre_id], except: [:say_hello]

  def say_hello
    # render json: {status: 200, message: "Hello world!"}
    #a=10

  end

  def new_sr
    @service_types = ServiceType.select(:id, :service_name).all()
    @service_centres = ServiceCentre.select(:id, :name).all()
    @service_centre_slots = ServiceCentreSlot.select(:id, :slot_start_time, :slot_end_time).all()
  end


  def update_profile_view
  end

  def update_profile
    @user = current_user
    @user.update_attributes(user_params)

    redirect_to root_path
  end

  def create_service_request
    @vehicle = persist_vehicle
    @sr = persist_service_request(@vehicle)

    redirect_to show_srs_url(:c_id => @user.id)
  end

   # listing all the service request in user profile
   def list_service_requests
     service_requests = ServiceRequest.where(user_id: current_user.id)
     # we have used where instead of find because where will return array of result and find returns only single result.

     vehicle_ids = []
     service_type_ids = []
     service_centre_slot_ids = []
     service_centre_ids = []
     vehicles = nil

     service_requests.each do |sr|
       vehicle_ids << sr.vehicle_id
       service_type_ids << sr.service_type_id
       service_centre_slot_ids << sr.service_centre_slot_id
       service_centre_ids <<  sr.service_centre_id
     end

     vehicles_by_id = {}
     if vehicle_ids.present?
       vehicles = Vehicle.where(id: vehicle_ids).all #.all is to be removed.
       # SELECT `vehicles`.* FROM `vehicles` WHERE `vehicles`.`id` IN (1, 2, 3)

       vehicles.each do |v|
         vehicles_by_id[v.id] ||= v
       #   traversing ,if this vehicle id is already there then leave else insert
       #   suppose vehicle id 4 comes 3times then instead of taking it again and again take it only ones.
       end
     end

     service_types_by_id = {}
     if service_type_ids.present?
       service_types = ServiceType.where(id: service_type_ids)

       service_types.each do |v|
         service_types_by_id[v.id] ||= v
       end
     end

     service_centres_by_id = {}
     if service_centre_ids.present?
       service_centres = ServiceCentre.where(id: service_centre_ids)

       service_centres.each do |v|
         service_centres_by_id[v.id] ||= v
       end
     end

     @final_data = []
     service_requests.each do |sr|
       i=10

       @final_data << {
           model: vehicles_by_id[sr.vehicle_id].model,
           request_date: sr.created_at.strftime("%Y %M %d, %I:%m"),
           state: sr.state,
           actual_bill: sr.actual_bill,
           estimated_bill: sr.estimated_bill,
           service_centre: service_centres_by_id[sr.service_centre_id].name,
           service_type: service_types_by_id[sr.service_type_id].service_name,
           vehicle_number: vehicles_by_id[sr.vehicle_id].number
       }
     end

     #render json: @final_data

   end


   def get_slots_by_service_centre_id
     sc_id = params[:sevice_centre_id]

     slots = ServiceCentreSlot.select(:id, :slot_start_time,:slot_end_time,:service_centre_id)
                 .where(service_centre_id: sc_id)
     #gives me slots snd id of slot of selected service centre


     response = {
         available_slots: []
     }


     # **
     # NOTE: (suppose there is condition to render at this point)
     #render json: response and return

     #json obejct and json array is initialised

     slots.each do |s|
        start_time = s.slot_start_time.strftime("%I:%M %p")
        end_time = s.slot_end_time.strftime("%I:%M %p")
        # taking start and end slot time in variable and converting it into proper time format

        response[:available_slots] << {
            id: s.id,
            start_time: start_time,
            end_time: end_time
        }
       #value are passed into emty hash
     end

     render json: response
     #if this line wudnt have been here ,then this wuld start searching for view which is not here ,hence it is sending value in json formatt which is parsed
   end



  private
  def persist_user
    user = User.new(user_params)
    # todo: handle error case
    user.save
    user
  end

  def persist_vehicle
    strong_vehicle_params = vehicle_params
    strong_vehicle_params[:user_id] = current_user.id
    vehicle=Vehicle.new(strong_vehicle_params)
    vehicle.save
    vehicle
  end

  def persist_service_request(v)
    strong_sr_params = sr_params
    strong_sr_params[:user_id] = current_user.id
    strong_sr_params[:vehicle_id] = v.id

    sr = ServiceRequest.new(strong_sr_params)
    sr.state = 'created'

    sr.save
    sr
  end

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :pincode, :contact_no)
  end

  def vehicle_params
    params.require(:vehicle).permit(:vehicle_type, :model, :number, :owner_name, :year, :user_id)
  end

  def sr_params
    params.require(:sr).permit(:service_type_id, :service_centre_id, :service_centre_slot_id)
  end
end

