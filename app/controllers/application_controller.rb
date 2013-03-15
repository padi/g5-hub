class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def extract_id_from_urn
    params[:id].split("-").third
  end

  def extract_client_id_from_urn
    params[:client_id].split("-").third
  end
end
