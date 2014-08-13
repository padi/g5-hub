class EntriesController < ApplicationController
  before_filter :authenticate_api_user!, unless: :is_navigational_format?
  before_filter :authenticate_user!, if: :is_navigational_format?

  def index
    client_scope = Client.order("updated_at DESC")
    @clients = ClientDecorator.decorate_collection(client_scope)
    fresh_when last_modified: client_scope.maximum(:updated_at)
  end

  def show
    @client = Client.find_by_urn(params[:id]).decorate
  end
end
