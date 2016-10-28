require 'test_helper'

class ScraperConfigTest < Test::Unit::TestCase

  test 'can check if debug mode enabled even when no ini file' do
    refute Tess::API.debug?
  end

  test 'can get config values' do
    assert Tess::API.config.keys.any?
  end

  test 'can load config from file' do
    Tess::API.load_config(File.join(File.dirname(__FILE__), 'fixtures', 'example_config.txt'))
    assert_equal 12345, Tess::API.config['google_api_key']
    assert Tess::API.debug?
  end

end
