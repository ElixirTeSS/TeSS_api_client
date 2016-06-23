class ContentProvider

  PROVIDER_TYPE = {
      :ORGANISATION => "Organisation",
      :PORTAL => "Portal",
      :PROJECT => "Project"
      }#, :Individual' => "Individual"}

  attr_accessor :title, :url, :image_url, :description, :id, :content_provider_type, :node_name, :keywords

  def initialize(options={})
    @title = options[:title]
  	@url = options[:url]
  	@image_url = options[:image_url]
    @description = options[:description]
    @id = options[:id]
    @content_provider_type = options[:content_provider_type] || PROVIDER_TYPE[:ORGANISATION]
    @node_name = options[:node]
    @keywords = options[:keywords] || []
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

