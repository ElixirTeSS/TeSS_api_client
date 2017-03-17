module Tess
  module API
    module ApiResource

      attr_accessor :last_action, :errors

      def create
        begin
          response = Uploader.do_upload(self, true, self.class.data_type, "/#{self.class.resource_path}.json", :post)
          self.id = response['id']
          self.last_action = :create
        rescue RestClient::ExceptionWithResponse => e
          self.errors = error_message(e)
        end

        self
      end

      def update
        begin
          Uploader.do_upload(self, true, self.class.data_type, "/#{self.class.resource_path}/#{self.id}.json", :put)
          self.last_action = :update
        rescue RestClient::ExceptionWithResponse => e
          self.errors = error_message(e)
        end

        self
      end

      def create_or_update
        if exists?
          update
        else
          create
        end
      end

      def find_or_create
        create unless exists?

        self
      end

      def exists?
        response = Uploader.do_upload(self, false, self.class.data_type, "/#{self.class.resource_path}/check_exists.json", :post)
        self.id = response['id']

        !response['id'].nil?
      end

      private

      def error_message(exception)
        begin
          JSON.parse(exception.response)
        rescue JSON::ParserError
          { 'exception' => "#{exception.class.name}: #{exception.message}" }
        end
      end

    end
  end
end
