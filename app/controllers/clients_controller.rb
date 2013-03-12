class ClientsController < ApplicationController
  def index
    client_scope = Client.order("updated_at DESC")
    @clients = ClientDecorator.decorate_collection(client_scope)
  end

  def show
    @client = Client.find_by_urn(params[:id]).decorate
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
