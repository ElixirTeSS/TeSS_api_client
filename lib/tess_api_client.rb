module Tess
  module API
    require 'inifile'
    require 'net/http'
    require 'net/https'
    require 'json'
    require 'open-uri'
    require 'digest/sha1'
    require 'rest-client'

    require 'tess/api/exceptions'
    require 'tess/api/api_resource'
    require 'tess/api/has_content_provider'
    require 'tess/api/resource'
    require 'tess/api/material'
    require 'tess/api/node'
    require 'tess/api/content_provider'
    require 'tess/api/event'
    require 'tess/api/uploader'

    def self.config
      @@config ||= self.load_config
    end

    def self.config= hash
      @@config = hash
    end

    def self.load_config(ini_file = 'uploader_config.txt')
      ini = IniFile.load(ini_file)

      self.validate_config(ini)

      self.config = ini['Main']
    end

    def self.base_url
      if self.config['base_url']
        self.config['base_url'].chomp('/')
      else
        (self.config['protocol'] + '://' + self.config['host'] + ':' + self.config['port'].to_s)
      end
    end

    def self.debug?
      self.config['debug']
    end

    private

    def self.validate_config(ini)
      raise Tess::API::BadConfigException.new("Can't open config file: #{ini_file}") unless ini
      raise Tess::API::BadConfigException.new("Missing 'Main' section in config file") unless ini['Main']
      ['user_token', 'user_email'].each do |field|
        unless ini['Main'][field]
          raise Tess::API::BadConfigException.new("Missing '#{field}' under 'Main' section in config file")
        end
      end

      if !ini['Main']['base_url'] && (!ini['Main']['host'] || !ini['Main']['protocol'] || !ini['Main']['port'])
        raise Tess::API::BadConfigException.new("Missing 'base_url' under 'Main' section in config file")
      end
    end

  end
end
