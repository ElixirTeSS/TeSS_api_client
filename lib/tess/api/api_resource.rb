module Tess
  module API
    module ApiResource

      attr_accessor :last_action

      def create
        response = Uploader.do_upload(self, true, self.class.data_type, "/#{self.class.resource_path}.json", :post)
        self.id = response['id']
        self.last_action = :create

        self
      end

      def update
        Uploader.do_upload(self, true, self.class.data_type, "/#{self.class.resource_path}/#{self.id}.json", :put)
        self.last_action = :update

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

    end
  end
end
