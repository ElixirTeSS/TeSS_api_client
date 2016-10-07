require 'simplecov'
SimpleCov.start

require 'test/unit'
require 'vcr'
require 'tess_api_client'

ScraperConfig.test_settings = {
    'host' => 'localhost',
    'port' => '3001',
    'protocol' => 'http',
    'user_email' => 'test.user@example.com',
    'user_token' => 'MxpE_AQk3BNZvFU_ES9M'
}

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :webmock
end
