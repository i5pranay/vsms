class NavigationsController < ApplicationController
  include NavigationsHelper
  before_filter :authenticate_user!, except: [:get_slots_by_service_centre_id], except: [:say_hello]

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
    @user = current_user
  end

  def update_profile
    @user = current_user
    @user.update_attributes(user_params)

    redirect_to root_path
  end

  def create_service_request
    validate_update_capacity(params)

    params[:vehicle][:user_id] = current_user.id
    @vehicle = Vehicle.find_or_create_vehicle(params)

    @sr = persist_service_request(@vehicle)

    redirect_to new_sr_path, flash: {notice: "Servicerequest successfully generated"}
    #redirect_to show_srs_url(:c_id => @user.id)
  end

  # listing all the service request in user profile
  def list_service_requests
    service_requests = ServiceRequest.where(user_id: current_user.id)
    # we have used where instead of find because where will return array of result and find returns only single result.
    # module in navigation helper,method is called from there.(to make code short)
    @final_data = get_detailed_info_for_service_requests service_requests
    #render json: @final_data

  end

  def show_srs
    req_id = params[:req_id]
    service_request = ServiceRequest.where(id: req_id)
    @sr_info = get_detailed_info_for_service_requests(service_request).first

  end


  def get_slots_by_service_centre_id
    sc_id = params[:sevice_centre_id]

    slots = ServiceCentreSlot.select(:id, :slot_start_time, :slot_end_time, :service_centre_id)
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

  def get_service_type_by_id
    sc_id = params[:sc_id]

    service_types = ServiceType.select(:id, :service_name, :centre_id).where(centre_id: sc_id)

    response = {
        available_srvtyps: []
    }

    service_types.each do |s|
      service_name = s.service_name

      response[:available_srvtyps] << {
          id: s.id,
          service_name: service_name,
      }
    end
    render json: response
  end

  private
  def persist_user
    user = User.new(user_params)
    # todo: handle error case
    user.save
    user
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

  # creating strong params against attacks
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :pincode, :contact_no)
  end

  def sr_params
    params.require(:sr).permit(:service_type_id, :service_centre_id, :service_centre_slot_id, :service_date)
  end
end

