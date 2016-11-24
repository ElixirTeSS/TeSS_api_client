require 'test_helper'

class ScraperConfigTest < Test::Unit::TestCase

  test 'can check if debug mode enabled even when no ini file' do
    assert_nothing_raised do
      Tess::API.debug?
    end
  end

  test 'can get config values' do
    assert Tess::API.config.keys.any?
  end

  test 'can load config from file' do
    Tess::API.load_config(File.join(File.dirname(__FILE__), 'fixtures', 'example_config.txt'))
    assert_equal 12345, Tess::API.config['google_api_key']
    assert Tess::API.debug?
  end

  test 'base url can be specified either way' do
    Tess::API.load_config(File.join(File.dirname(__FILE__), 'fixtures', 'example_config.txt'))
    assert_equal 'http://localhost:3000', Tess::API.base_url

    Tess::API.load_config(File.join(File.dirname(__FILE__), 'fixtures', 'new_example_config.txt'))
    assert_equal 'http://localhost:3000', Tess::API.base_url
  end

  test 'raises exception on bad config' do
    assert_raise(Tess::API::BadConfigException) do
      Tess::API.load_config(File.join(File.dirname(__FILE__), 'fixtures', 'bad_config.txt'))
    end
  end

end
