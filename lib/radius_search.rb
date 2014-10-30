class RadiusSearch
  def initialize(client, params)
    @client = client
    @params = scrub_params(params)
  end

  def locations
    search_results = @client.locations.near(@params[:search], @params[:radius])
  end

  private

  def scrub_params(params)
    params[:search] ||= ""
    params[:radius] = (params[:radius].is_a? Numeric) ? params[:radius] : 20
    params
  end
end
