class EntriesController < ApplicationController
  def index
    clients = FoundationClient::Client.all.sort_by(&:updated_at).reverse
    @clients = ClientDecorator.decorate_collection(clients)

    if clients.present?
      fresh_when last_modified: clients.max_by(&:updated_at).updated_at
    end
  end

  def show
    client = FoundationClient::Client.find(extract_id_from_urn)
    @client = ClientDecorator.decorate(client)
  end
end
