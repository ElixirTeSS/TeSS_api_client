Gem::Specification.new do |s|
  s.name        = 'tess_api_client'
  s.version     = '0.4.0'
  s.date        = '2022-07-28'
  s.summary     = 'Libraries for uploading files to https://github.com/ElixirTeSS/TeSS'
  s.description = 'Uses the a Custom RoR API on https://tess.elixir-europe.org to upload data in the format being used by the TeSS project.'
  s.authors     = ['Milo Thurston','Niall Beard','Aleksandra Nenadic','Finn Bacall']
  s.email       = 'tess-support@googlegroups.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/ElixirTeSS/TeSS_api_client'
  s.license     = 'BSD'
  s.add_runtime_dependency 'inifile', '~> 3.0.0'
  s.add_runtime_dependency 'rest-client', '~> 2.0.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr', '~> 3.0.3'
  s.add_development_dependency 'simplecov'
end
