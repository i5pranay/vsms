class JavascriptsController < ApplicationController

  def dynamic_call

    @service_centre_slots = CreateServiceCentreSlot.find(:all)

  end

end
