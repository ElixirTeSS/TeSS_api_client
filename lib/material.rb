class Material
  attr_accessor :id, :title, :url, :short_description, :long_description, :doi,:last_scraped, :scraper_record,
                :remote_created_date,  :remote_updated_date, :package_ids, :content_provider_id,
                :content_provider, :keywords, :scientific_topic_names, :licence, :difficulty_level,
                :contributors, :authors, :target_audience, :node_ids, :external_resources_attributes

  def initialize(options={})
    @id = options[:id]
    @title = options[:title]
    @url = options[:url]
    @short_description = options[:short_description]
    @long_description = options[:long_description]
    @doi = options[:doi]
    @last_scraped = Time.now
    @scraper_record = true    
    @remote_created_date = options[:remote_created_date]
    @remote_updated_date = options[:remote_updated_date]
    @package_ids = options[:package_ids] #Array
    @content_provider_id = options[:content_provider_id]
    @content_provider = options[:content_provider]
    @keywords = options[:keywords] #Array
    @scientific_topic_names = options[:scientific_topic_names] #Array
    @licence = options[:licence]
    @difficulty_level = options[:difficulty_level]
    @contributors = options[:contributors] #Array
    @authors = options[:authors] #Array
    @target_audience = options[:target_audience] #Array
    @node_ids = options[:node_ids] #Array
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

