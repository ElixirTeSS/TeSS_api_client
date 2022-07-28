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

      attr_accessor :id, :title, :url, :description, :doi, :last_scraped, :scraper_record,
                    :remote_created_date,  :remote_updated_date, :package_ids, :keywords,
                    :scientific_topic_names, :scientific_topic_uris, :operation_names, :operation_uris,
                    :licence, :difficulty_level, :contributors, :authors, :target_audience, :node_ids,
                    :external_resources_attributes, :resource_type, :other_types, :date_created, :date_modified,
                    :date_published, :prerequisites, :version, :status, :syllabus, :subsets, :contact,
                    :learning_objectives, :fields

      def initialize(params = {})
        params[:last_scraped] = Time.now
        params[:scraper_record] = true
        # TODO: Check if this is really necessary:
        [:scientific_topic_names, :operation_names, :package_ids, :keywords, :contributors,
         :authors, :target_audience, :node_ids, :external_resources_attributes].each do |attr|
          params[attr] = [params[attr]].flatten.compact
        end

        super
      end

    end
  end
end
