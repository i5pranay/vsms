module NavigationsHelper

  def get_detailed_info_for_service_requests(service_requests)

    vehicle_ids = []
    service_type_ids = []
    service_centre_slot_ids = []
    service_centre_ids = []
    vehicles = nil
    user_ids = []

    service_requests.each do |sr|
      vehicle_ids << sr.vehicle_id
      service_type_ids << sr.service_type_id
      service_centre_slot_ids << sr.service_centre_slot_id
      service_centre_ids << sr.service_centre_id
      user_ids <<  sr.user_id
    end

    users_by_id = get_users_hash_by_id(user_ids)
    vehicles_by_id = get_vehicles_hash_by_id(vehicle_ids)
    service_types_by_id = get_service_type_hash_by_id(service_type_ids)
    service_centres_by_id = get_sc_hash_by_id(service_centre_ids)

    final_info = []
    service_requests.each do |sr|
      final_info << {
          id: sr.id,
          owner_name: vehicles_by_id[sr.vehicle_id].owner_name,
          year: vehicles_by_id[sr.vehicle_id].year,
          vehicle_type: vehicles_by_id[sr.vehicle_id].vehicle_type,
          user: users_by_id[sr.user_id].name,
          model: vehicles_by_id[sr.vehicle_id].model,
          service_date: sr.service_date,
          request_date: sr.created_at.strftime("%Y %M %d, %I:%m"),
          state: sr.state,
          actual_bill: sr.actual_bill,
          estimated_bill: sr.estimated_bill,
          service_centre: service_centres_by_id[sr.service_centre_id].name,
          service_type: service_types_by_id[sr.service_type_id].service_name,
          vehicle_number: vehicles_by_id[sr.vehicle_id].number
      }
    end

    final_info
  end

  def get_sc_hash_by_id(service_centre_ids)
    service_centres_by_id = {}
    if service_centre_ids.present?
      service_centres = ServiceCentre.where(id: service_centre_ids)

      service_centres.each do |v|
        service_centres_by_id[v.id] ||= v
      end
    end
    service_centres_by_id
  end

  def get_service_type_hash_by_id(service_type_ids)
    service_types_by_id = {}
    if service_type_ids.present?
      service_types = ServiceType.where(id: service_type_ids)

      service_types.each do |v|
        service_types_by_id[v.id] ||= v
      end
    end
    service_types_by_id
  end

  def get_vehicles_hash_by_id(vehicle_ids)
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
    vehicles_by_id
  end

  def get_users_hash_by_id(user_ids)
    users_by_id = {}
    if user_ids.present?
      users = User.where(id: user_ids)

      users.each do |v|
        users_by_id[v.id] ||= v
      end
    end
    users_by_id
  end


  def validate_update_capacity(hash)

     existing_capacity_used = SlotCapacity.where(service_centre_slot_id: hash[:sr][:service_centre_slot_id],
                                                service_date: hash[:sr][:service_date]).first

    if existing_capacity_used.present? # if capacity is already used by some sr
      new_capacity_used = existing_capacity_used.capacity_used + 1

      raise "Capacity already full for this slot. Try another slot!" if new_capacity_used > 1

      # store the new capacity used in DB
      existing_capacity_used.update_attributes(capcity_used: new_capacity_used)

    else
      # case when capacity is not even used by any sr
      slot_capacity = SlotCapacity.add_new_capacity(hash)

    end
  end
end
