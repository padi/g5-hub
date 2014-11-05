class RadiusSearch
  def initialize(client, params)
    @client = client
    @params = scrub_params(params)
  end

  def locations
    search_results = @client.locations.near(@params[:search], @params[:radius])
  end

  def results
    success = self.locations.empty? ? false : true
    locations = success ? self.locations : @client.locations
    
    response = {  success: success,
                  locations: locations.as_json(only: [:id, :name, :street_address_1, :street_address_2, :city, :state, :postal_code, :phone_number, :email, :domain, :latitude, :longitude], methods: [:thumbnail]) }
  end

  private

  def scrub_params(params)
    params[:search] ||= ""
    params[:radius] = (params[:radius].is_a? Numeric) ? params[:radius] : 20
    params
  end
end
