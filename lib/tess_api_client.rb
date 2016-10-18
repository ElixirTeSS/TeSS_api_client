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
    require 'tess/api/scraper_config'
  end
end
