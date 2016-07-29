class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #before_filter :authenticate_user!

  before_filter :validate_authenticity

  def validate_authenticity
    prefix = request.path.split("/")[1]
 a=10;
    if ["sco", "customer", "super_admin"].include?(prefix)
      redirect_to root_url, flash: { error: "Caught you!.. Not authenticated to access this url!.."} if current_user.role != prefix
    end
  end
end
