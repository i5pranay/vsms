class SlotCapacity < ActiveRecord::Base

  class << self
    MAX_CAPACITY_PER_SLOT = 1

    def add_new_capacity(hash)
      slot_capacity = SlotCapacity.new(capacity_strong_params(hash))
      slot_capacity.save
      slot_capacity
    end

    private
    def capacity_strong_params(hash)
      hash.require(:sr).permit(:service_centre_slot_id, :service_date)
    end
  end
end
