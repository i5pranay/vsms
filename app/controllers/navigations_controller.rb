class NavigationsController < ApplicationController
  before_filter :authenticate_user! , except: [:get_slots_by_service_centre_id], except: [:say_hello]

  def say_hello
    # render json: {status: 200, message: "Hello world!"}
    a=10

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

