class Material
  attr_accessor :title, :url, :short_description, :doi, :remote_updated_date, :remote_created_date, :content_provider_id,
                :scientific_topic_names, :keywords, :id, :authors, :long_description


  def initialize(options={})
    @title = options[:title]
    @url = options[:url]
    @short_description = options[:short_description]
    @doi = options[:doi]
    @remote_updated_date = options[:remote_updated_date]
    @remote_created_date = options[:remote_created_date]
    @content_provider_id = options[:content_provider_id]
    @licence = options[:licence]
    @id = options[:id]
    @long_description = options[:long_description]
    @difficulty_level = options[:difficulty_level]
    @scientific_topic_names = options[:scientific_topics] || []
    @keywords = options[:keywords] || []
    @contributors = options[:contributors] || []
    @authors = options[:authors] || []
    @target_audience = options[:target_audience] || []
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

