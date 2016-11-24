module Tess
  module API
    class Node < Resource

      attr_accessor :name, :url, :image_url, :description, :member_status, :id

      NODE_NAMES = {
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
          member: 'Member',
          observer: 'Observer'
      }

      cv_attributes(member_status: MEMBER_STATUS)

      def initialize(params = {})
        params[:member_status] ||= :observer

        super
      end

    end
  end
end
