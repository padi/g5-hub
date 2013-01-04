class ClientsController < ApplicationController

  def index
    @clients = Client.order("updated_at DESC")
    fresh_when last_modified: @clients.maximum(:updated_at)
  end

  def show
    @client = Client.find_by_urn(params[:id])
  end

  def new
    @client = Client.new
    @client.locations.build
  end

  def create
    @client = Client.new(params[:client])
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
    if @client.update_attributes(params[:client])
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
