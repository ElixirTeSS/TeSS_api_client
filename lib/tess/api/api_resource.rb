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

      #we can refactor the unscraped and eventunscraped functions beneath in a single one like this
      #this current refactor does not work, todo in the future if we want to clean up the code
      #def unscraped?                
      #  if self.class.data_type == :event
      #      type = "eventunscraped"
      #  elsif self.class.data_type== :material
      #     type = "unscraped"
      #  end  
              
      #  data = {type:{"url": self.url}}
      #  response = Uploader.lookup_unscraped(data, "/"+type+"s"+"/check_exists.json", :post)
      #  self.id = response['id']

      #  !response['id'].nil?
      #end


      #these work fine, tested them
      def unscraped?
        #puts self.url
        data = {"unscraped":{"url": self.url}}
        response = Uploader.lookup_unscraped(data, "/unscrapeds/check_exists.json", :post)
        self.id = response['id']
              
        !response['id'].nil?
      end

      def eventunscraped?
        #puts self.url
        data = {"eventunscraped":{"url": self.url}}
        response = Uploader.lookup_unscraped(data, "/eventunscrapeds/check_exists.json", :post)
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
