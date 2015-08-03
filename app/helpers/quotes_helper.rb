module QuotesHelper

  NETWORK_TYPES = {
    internet: "Internet",
    private: "Private",
    mpls: "MPLS",
    vpls: "VPLS",
    vpn: "VPN"
  }

  SPEEDS = {
    10 => "10MB",
    100 => "100MB",
    1000 => "1GB",
    10000 => "10GB"
  }

  def quote_item_attribute(attr_name, id = nil, value = nil)
    res = "quote[quote_items_attributes][#{id}][#{attr_name}]"
    res << "_#{value}" unless value.nil?

    res
  end

  def options_for_network
    options_for_select NETWORK_TYPES.map{ |k,v | [v, k] }
  end

  def options_for_speed
    options_for_select SPEEDS.map { |k,v| [v,k] }
  end

  def options_for_companies
    options_from_collection_for_select(Company.with_network_products, :id, :name)
  end

  def network_type(network)
    NETWORK_TYPES[network.try(:to_sym)]
  end

  def connection_speed(speed)
    SPEEDS[speed]
  end

end
