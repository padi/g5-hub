class RadiusSearch
  def initialize(client, params)
    @client = client
    @params = params
  end

  def locations
    @client.locations.first(3)
  end
end