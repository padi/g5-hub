class LocationsController < ApplicationController
  def show
    @location = Location.find_by_urn(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    if @location.save
      redirect_to clients_url, :notice => "Successfully created location."
    else
      render :action => 'new'
    end
  end

  def edit
    @location = Location.find_by_urn(params[:id])
  end

  def update
    @location = Location.find_by_urn(params[:id])
    if @location.update_attributes(params[:location])
      redirect_to clients_url, :notice  => "Successfully updated location."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @location = Location.find_by_urn(params[:id])
    @location.destroy
    redirect_to clients_url, :notice => "Successfully destroyed location."
  end
end
