class Event
  attr_accessor :external_id, :title,:subtitle,:url,:provider,:field,:description,:keywords,:category,
      :start,:end,:sponsor,:venue,:city,:county, :country,:postcode,:latitude,:longitude,:id, 
      :content_provider_id,:last_scraped,:scraper_record

  def initialize(options={})
    @id = options[:id]
    @content_provider_id = options[:content_provider_id]
    @external_id = options[:external_id]
    @title = options[:title]
    @subtitle = options[:subtitle]
    @url = options[:url]
    @provider = options[:provider]
    @field = options[:field]
    @description = options[:description]
    @keywords = options[:keywords]
    @category = options[:category]
    @start = options[:start_date]
    @end = options[:end_date]
    @sponsor = options[:sponsor]
    @venue = options[:venue]
    @city = options[:city]
    @county = options[:county]
    @country = options[:country]
    @postcode = options[:postcode]
    @latitude = options[:latitude]
    @longitude = options[:longitude]
    @last_scraped = Time.now
    @scraper_record = true
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

