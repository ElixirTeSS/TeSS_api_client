module Tess
  module API
    class Uploader

      def self.do_upload(data, auth, data_type, action, method)
        payload = { data_type => data.dump }

        if auth
          payload[:user_email] = Tess::API.config['user_email']
          payload[:user_token] = Tess::API.config['user_token']
        end

        response = RestClient::Request.execute(method: method.to_sym,
                                               url: (Tess::API.base_url + action),
                                               payload: payload.to_json,
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
