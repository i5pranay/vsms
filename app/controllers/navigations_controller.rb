class NavigationsController < ApplicationController
  def say_hello
    # render json: {status: 200, message: "Hello world!"}
    a=10

  end

  def new_sr
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

