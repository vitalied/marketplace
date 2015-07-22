module LocationsHelper

  def location_address(location)
    [location.address.presence, location.city.presence, location.state.presence, location.zip.presence].compact.join(", ")
  end

  def list_location_address(location)
    [location.address.presence, location.city.presence, location.state.presence].compact.join(", ")
  end

end
