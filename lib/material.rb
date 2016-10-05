class Material < Resource

  attr_accessor :id, :title, :url, :short_description, :long_description, :doi,:last_scraped, :scraper_record,
                :remote_created_date,  :remote_updated_date, :package_ids, :content_provider_id,
                :keywords, :scientific_topic_names, :licence, :difficulty_level,
                :contributors, :authors, :target_audience, :node_ids, :external_resources_attributes

  def initialize(params = {})
    params[:last_scraped] = Time.now
    params[:scraper_record] = true
    # TODO: Check if this is really necessary:
    [:scientific_topic_names, :package_ids, :keywords, :contributors,
     :authors, :target_audience, :node_ids].each do |attr|
      params[attr] = [params[attr]].flatten
    end

    super
  end

end
