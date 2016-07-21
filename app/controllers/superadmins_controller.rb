class SuperadminsController < ApplicationController

  def update_user_role_view
    @service_centres = ServiceCentre.select(:id ,:name).all

  end

  def update_user_role


    ## other ways
    # user = User.find_by(email: params[:email])
    # user = User.find_by_email(params[email])

    user = User.where(email: params[:email])
    if user.present?
      user.first.update_attributes(role: params[:role])

      ServiceCentre.where(id: params[:service_centre_id]).update_all(owner_id: user.first.id )


      @msg = "successfully updated the role"
      @html_class = "alert-success"
    else
      @msg = "could not find user with given email id " + params[:email]
      @html_class = "alert-danger"
    end
  rescue
    @msg = "failed to update the role"
    @html_class = "alert-danger"
  end

  private
  def create_alerts(msg, html_class)
    @msg = msg
    @html_class = html_class
  end

end
