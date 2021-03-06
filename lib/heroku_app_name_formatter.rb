class HerokuAppNameFormatter
  HEROKU_APP_NAME_LIMIT = 29

  def initialize(client)
    @client = client
  end

  def formatted_cms_app_name
    cms_app_name.gsub(/\A[-\.]+|[-\.]+\z/, "")
  end

  def formatted_cms_url
    "https://#{formatted_cms_app_name}.herokuapp.com"
  end

  private

  def cms_app_name
    @cms_app_name ||= cms_urn[0..HEROKU_APP_NAME_LIMIT]
  end

  def cms_urn
    @client.urn.gsub("-c-","-cms-")
  end
end
