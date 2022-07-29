module Tess
  module API
    class Material < Resource

      include ApiResource
      include HasContentProvider

      def self.data_type
        :material
      end

      def self.resource_path
        'materials'
      end

      attr_accessor :id, :title, :url, :contact, :description, :doi, :licence, :last_scraped, :scraper_record,
                    :remote_created_date, :remote_updated_date, :difficulty_level, :version, :status,
                    :date_created, :date_modified, :date_published, :other_types, :prerequisites, :syllabus,
                    :learning_objectives, :subsets, :contributors, :authors, :target_audience, :collection_ids,
                    :keywords, :resource_type, :scientific_topic_names, :scientific_topic_uris, :operation_names,
                    :operation_uris, :node_ids, :node_names, :fields, :external_resources_attributes, :event_ids


      def initialize(params = {})
        params[:last_scraped] = Time.now
        params[:scraper_record] = true
        # TODO: Check if this is really necessary:
        [:scientific_topic_names, :operation_names, :collection_ids, :keywords, :contributors,
         :authors, :target_audience, :node_ids, :external_resources_attributes].each do |attr|
          params[attr] = [params[attr]].flatten.compact
        end

        super
      end

    end
  end
end
