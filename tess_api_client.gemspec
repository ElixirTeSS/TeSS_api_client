Gem::Specification.new do |s|
  s.name        = 'tess_api_client'
  s.version     = '0.4.3'
  s.date        = '2024-12-12'
  s.summary     = 'Libraries for uploading files to https://github.com/ElixirTeSS/TeSS'
  s.description = 'Uses the legacy JSON API on https://tess.elixir-europe.org'
  s.authors     = ['Milo Thurston','Niall Beard','Aleksandra Nenadic','Finn Bacall']
  s.email       = 'tess-support@googlegroups.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/ElixirTeSS/TeSS_api_client'
  s.license     = 'BSD'
  s.add_runtime_dependency 'inifile', '~> 3.0.0'
  s.add_runtime_dependency 'rest-client', '~> 2.1.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr', '~> 6.2.0'
  s.add_development_dependency 'test-unit', '~> 3.5.3'
  s.add_development_dependency 'simplecov'
end
