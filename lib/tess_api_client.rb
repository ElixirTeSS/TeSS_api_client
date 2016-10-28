module Tess
  module API
    require 'inifile'
    require 'net/http'
    require 'net/https'
    require 'json'
    require 'httparty'
    require 'open-uri'
    require 'digest/sha1'

    require 'tess/api/api_resource'
    require 'tess/api/has_content_provider'
    require 'tess/api/resource'
    require 'tess/api/material'
    require 'tess/api/content_provider'
    require 'tess/api/event'
    require 'tess/api/node'
    require 'tess/api/uploader'

    def self.config
      @@config ||= self.load_config
    end

    def self.config= hash
      @@config = hash
    end

    def self.load_config(ini_file = 'uploader_config.txt')
      ini = IniFile.load(ini_file)

      raise "Can't open config file: #{ini_file}" unless ini
      raise "Missing 'Main' section in config file" unless ini['Main']

      self.config = ini['Main']
    end

    def self.debug?
      self.config['debug']
    end

  end
end
