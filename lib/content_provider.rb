class ContentProvider < Resource

  attr_accessor :title, :url, :image_url, :description, :id, :content_provider_type, :node_name, :keywords

  PROVIDER_TYPE = {
      :ORGANISATION => "Organisation",
      :PORTAL => "Portal",
      :PROJECT => "Project"
  }

  def initialize(params = {})
    params[:content_provider_type] ||= PROVIDER_TYPE[:ORGANISATION]
    params[:node_name] ||= params.delete(:node)

    super
  end

end
