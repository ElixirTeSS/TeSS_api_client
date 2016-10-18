module Tess
  module API
    module HasContentProvider

      attr_accessor :content_provider, :content_provider_id

      def content_provider_id
        @content_provider ? @content_provider.id : @content_provider_id
      end

      def update
        @content_provider.create_or_update if @content_provider && !content_provider_id

        super
      end

      def create
        @content_provider.create_or_update if @content_provider && !content_provider_id

        super
      end

      def dump
        hash = super
        if hash.key?('content_provider')
          hash['content_provider_id'] ||= hash['content_provider'].id
          hash.delete('content_provider')
        end

        hash
      end

    end
  end
end
