class Node

  NODE_NAMES={
      :CZ => "Czech Republic",
      :DK => "Denmark",
      :'EMBL-EBI' => "EMBL-EBI",
      :EE => "Estonia",
      :FI => "Finland",
      :FR => "France",
      :GR => "Greece",
      :IL => "Israel",
      :IT => "Italy",
      :IE => "Ireland",
      :NL => "Netherlands",
      :NO => "Norway",
      :PT => "Portugal",
      :BE => "Belgium",
      :SI => "Slovenia",
      :ES => "Spain",
      :SE => "Sweden",
      :CH => "Switzerland",
      :GB => "United Kingdom"
  }

  MEMBER_STATUS = {
      :MEMBER => 'Member',
      :OBSERVER => 'Observer'
  }

  attr_accessor :name, :url, :image_url, :description, :member_status, :id

  def initialize(options={})
    @name = options[:title]
    @url = options[:url]
    @image_url = options[:image_url]
    @description = options[:description]
    @member_status = options[:member_status] || MEMBER_STATUS[:OBSERVER]
    @id = options[:id]
  end
end