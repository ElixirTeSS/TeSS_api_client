module Tess
  module API
    class ScraperConfig

      def self.test_settings= settings
        @@test_settings = settings
      end

      def self.get_config
        return @@test_settings if @@test_settings

        host, port, protocol, user_email, user_token = nil
        myini = self.load_config

        unless myini
          raise "Can't open config file!"
        end

        myini.each_section do |section|
          if section == 'Main'
            host = myini[section]['host']
            port = myini[section]['port']
            protocol = myini[section]['protocol']
            user_email = myini[section]['user_email']
            user_token = myini[section]['user_token']
          end
        end

        return {
            'host' => host,
            'port' => port,
            'protocol' => protocol,
            'user_email' => user_email,
            'user_token' => user_token
        }
      end

      def self.debug?
        (self.load_config['Main'] && self.load_config['Main']['debug'])
      end

      def self.google_api_key
        (self.load_config['Main'] && self.load_config['Main']['google_api_key']) || ''
      end

      def self.load_config
        IniFile.load('../uploader_config.txt')
      end
    end
  end
end
