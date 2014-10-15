class EntriesController < ApplicationController
  before_filter :authenticate_api_user!, if: :is_api_request?
  before_filter :authenticate_user!, unless: :is_api_request?

  def index
    client_scope = Client.order("updated_at DESC")
    @clients     = ClientDecorator.decorate_collection(client_scope)

    if stale? last_modified: client_scope.maximum(:updated_at)
      respond_to do |format|
        format.html
        format.json { render json: client_scope, root: :clients }
      end
    end
  end

  def show
    @client = Client.find_by_urn(params[:id]).decorate
  end
end
