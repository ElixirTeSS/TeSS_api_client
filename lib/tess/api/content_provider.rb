module Tess
  module API
    class ContentProvider < Resource

      include ApiResource

      def self.data_type
        :content_provider
      end

      def self.resource_path
        'content_providers'
      end

      attr_accessor :title, :url, :image_url, :description, :id, :content_provider_type, :node_name, :keywords,
                    :contact

      PROVIDER_TYPE = {
          organisation: 'Organisation',
          portal: 'Portal',
          project: 'Project'
      }

      cv_attributes({ content_provider_type: PROVIDER_TYPE, node_name: Tess::API::Node::NODE_NAMES })

      def initialize(params = {})
        params[:content_provider_type] ||= :organisation
        params[:node_name] ||= params.delete(:node)

        super
      end

    end
  end
end
