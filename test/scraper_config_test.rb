require 'test_helper'

class ScraperConfigTest < Test::Unit::TestCase

  test 'can check if debug mode enabled even when no ini file' do
    refute Tess::API::ScraperConfig.debug?
  end

  test 'can check Google API key even when no ini file' do
    assert_equal '', Tess::API::ScraperConfig.google_api_key
  end

end
