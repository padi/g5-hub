class ClientsController < ApplicationController
  def index
    client_scope = Client.order("updated_at DESC")
    @clients = ClientDecorator.decorate_collection(client_scope)
  end

  def show
    @client = Client.find_by_urn!(params[:id]).decorate
  end

  def new
    @client = Client.new
    @client.locations.build
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_url, :notice => "Successfully created client."
    else
      @client.locations.build if @client.locations.blank?
      render :action => 'new'
    end
  end

  def edit
    @client = Client.find_by_urn(params[:id])
    @client.locations.build if @client.locations.blank?
  end

  def update
    @client = Client.find_by_urn(params[:id])
    if @client.update_attributes(client_params)
      redirect_to clients_url, :notice  => "Successfully updated client."
    else
      @client.locations.build if @client.locations.blank?
      render :action => 'edit'
    end
  end

  def destroy
    @client = Client.find_by_urn(params[:id])
    @client.destroy
    redirect_to clients_url, :notice => "Successfully destroyed client."
  end
end

private

  def client_params
    params.fetch(:client, {}).permit(:name, :street_address_1, :street_address_2,
    :city, :state, :postal_code, :fax, :email, :vertical, :urn,
    locations_attributes: [:id, :name, :street_address_1, :street_address_2,
    :city, :state, :postal_code, :fax, :email, :corporate,
    :urn, :hours, :twitter_username, :facebook_username, :yelp_username,
    :pinterest_username, :foursquare_username, :tumblr_username,
    :instagram_username, :vimeo_username, :youtube_username, :domain, :phone_number])
  end
