Gem::Specification.new do |s|
  s.name        = 'tess_api_client'
  s.version     = '0.1.13'
  s.date        = '2016-09-01'
  s.summary     = 'Libraries for uploading files to http://tess.oerc.ox.ac.uk'
  s.description = 'Uses the a Custom RoR API on https://tess.elixir-uk.org to upload data in the format being used by the TeSS project.'
  s.authors     = ['Milo Thurston','Niall Beard','Aleksandra Nenadic','Finn Bacall']
  s.email       = 'milo.thurston@oerc.ox.ac.uk'
  s.files       = ['lib/resource.rb','lib/tess_api_client.rb','lib/material.rb','lib/event.rb','lib/content_provider.rb','lib/uploader.rb','lib/scraper_config.rb','lib/rdfa_extractor.rb','lib/node.rb']
  s.homepage    = 'https://github.com/ElixirUK/TeSS_api_client'
  s.license     = 'BSD'
  s.add_runtime_dependency 'json', '~> 1.8'
  s.add_runtime_dependency 'httparty', '~> 0.13'
  s.add_runtime_dependency 'net', '~> 0.3'
  s.add_runtime_dependency 'linkeddata', '~> 2.0'
  s.add_runtime_dependency 'inifile', '~> 3.0.0'
  s.add_development_dependency 'test-unit', '~> 3.2.1'
end
