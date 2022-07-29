module Tess
  module API
    class Event < Resource

      include ApiResource
      include HasContentProvider

      def self.data_type
        :event
      end

      def self.resource_path
        'events'
      end

      attr_accessor :id, :external_id, :title, :subtitle, :url, :organizer, :last_scraped, :scraper_record, :description,
                    :scientific_topic_names, :scientific_topic_uris, :operation_names, :operation_uris,
                    :event_types, :keywords, :fields, :start, :end, :duration, :sponsors, :online, :venue,
                    :city, :county, :country, :postcode, :latitude, :longitude, :timezone, :collection_ids, :node_ids,
                    :node_names, :target_audience, :eligibility, :host_institutions, :capacity, :contact, :recognition,
                    :learning_objectives, :prerequisites, :tech_requirements, :cost_basis, :cost_value, :cost_currency,
                    :external_resources_attributes


      EVENT_TYPE = {
          awards_and_prizegivings: 'awards_and_prizegivings',
          meetings_and_conferences: 'meetings_and_conferences',
          receptions_and_networking: 'receptions_and_networking',
          workshops_and_courses: 'workshops_and_courses'
      }

      cv_attributes(event_types: EVENT_TYPE)

      def initialize(params = {})
        params[:last_scraped] = Time.now
        params[:scraper_record] = true

        super
      end

    end
  end
end
