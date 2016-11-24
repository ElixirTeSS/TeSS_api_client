module Tess
  module API
    class Uploader

      # The following methods are just to maintain backwards compatibility
      def self.check_material(material)
        warn '[DEPRECATION] Uploader.check_material is deprecated, please use Material#exists? instead'
        material.exists?
      end

      def self.create_material(material)
        warn '[DEPRECATION] Uploader.create_material is deprecated, please use Material#create instead'
        material.create
      end

      def self.update_material(material)
        warn '[DEPRECATION] Uploader.update_material is deprecated, please use Material#update instead'
        material.update
      end

      def self.create_or_update_material(material)
        warn '[DEPRECATION] Uploader.create_or_update_material is deprecated, please use Material#create_or_update instead'
        material.create_or_update
      end

      def self.check_event(event)
        warn '[DEPRECATION] Uploader.check_event is deprecated, please use Event#exists? instead'
        event.exists?
      end

      def self.create_event(event)
        warn '[DEPRECATION] Uploader.create_event is deprecated, please use Event#create instead'
        event.create
      end

      def self.update_event(event)
        warn '[DEPRECATION] Uploader.update_event is deprecated, please use Event#update instead'
        event.update
      end

      def self.create_or_update_event(event)
        warn '[DEPRECATION] Uploader.create_or_update_event is deprecated, please use Event#create_or_update instead'
        event.create_or_update
      end

      def self.check_content_provider(content_provider)
        warn '[DEPRECATION] Uploader.check_content_provider is deprecated, please use ContentProvider#exists? instead'
        content_provider.exists?
      end

      def self.create_content_provider(content_provider)
        warn '[DEPRECATION] Uploader.create_content_provider is deprecated, please use ContentProvider#create instead'
        content_provider.create
      end

      def self.update_content_provider(content_provider)
        warn '[DEPRECATION] Uploader.update_content_provider is deprecated, please use ContentProvider#update instead'
        content_provider.update
      end

      def self.create_or_update_content_provider(content_provider)
        warn '[DEPRECATION] Uploader.create_or_update_content_provider is deprecated, please use ContentProvider#create_or_update instead'
        content_provider.create_or_update
      end

      def self.do_upload(data, auth, data_type, action, method)
        # The data to post must be converted to JSON and
        # the proper auth details added.
        if auth
          payload = { user_email: Tess::API.config['user_email'],
                      user_token: Tess::API.config['user_token'],
                     data_type => data.dump
          }.to_json
        else
          payload = data.to_json
        end

        response = RestClient::Request.execute(method: method.to_sym,
                                               url: (Tess::API.base_url + action),
                                               payload: payload,
                                               headers: { content_type: 'application/json'})

        begin
          JSON.parse(response.body)
        rescue JSON::ParserError
          {}
        end
      end

    end
  end
end
