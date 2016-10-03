class Event
  attr_accessor :id, :external_id, :content_provider_id, :title, :subtitle, :url, :organizer, :last_scraped,
                :scraper_record, :description, :scientific_topic_names, :event_types,
                :keywords, :start, :end, :sponsor, :online, :for_profit, :venue,
                :city, :county, :country, :postcode, :latitude, :longitude,
                :package_ids, :node_ids, :target_audience, :eligibility,
                :host_institutions, :capacity, :contact, 
                :external_resources_attributes

  EVENT_TYPE = {
      :awards_and_prizegivings => "awards_and_prizegivings",
      :meetings_and_conferences => "meetings_and_conferences",
      :receptions_and_networking => "receptions_and_networking",
      :workshops_and_courses => "workshops_and_courses"
      }


  def initialize(options={})
    @id = options[:id]
    @content_provider_id = options[:content_provider_id]
    @external_id = options[:external_id]
    @title = options[:title]
    @subtitle = options[:subtitle]
    @url = options[:url]
    @organizer = options[:organizer]
    @last_scraped = Time.now
    @scraper_record = true
    @description = options[:description]
    @scientific_topic_names = options[:scientific_topic_names] #Array
    @event_types =  options[:event_types] #Array
    @keywords = options[:keywords] #Array
    @start = options[:start_date]
    @end = options[:end_date]
    @sponsor = options[:sponsor]
    @online = options[:online] #Boolean
    @for_profit = options[:for_profit] #Boolean
    @venue = options[:venue]
    @city = options[:city]
    @county = options[:county]
    @country = options[:country]
    @postcode = options[:postcode]
    @latitude = options[:latitude]
    @longitude = options[:longitude]
    @package_ids = options[:package_ids] #Array
    @node_ids = options[:node_ids] #Array
    @target_audience = options[:target_audience] #Array
    @eligibility = options[:eligibility] #Array
    @host_institutions = options[:host_institutions] #Array
    @capacity = options[:capacity]
    @contact  = options[:contact]
    @external_resources_attributes = options[:external_resources_attributes] # Hash = [:id => x, :url => y, :title => z, :_destroy => true]
  end


  def dump
    hash = {}
    self.instance_variables.each do |var|
      varname = var.to_s.gsub(/@/,'')
      hash[varname] = self.instance_variable_get var
    end
    return hash
  end

  def to_json
    return self.dump.to_json
  end

  def [](var)
    return self.send(var)
  end

end

