require 'test_helper'

class EventTest < Test::Unit::TestCase

  test 'can initialize an event' do
    assert_nothing_raised do
      Event.new({ content_provider_id: 123,
                  title: 'A new event',
                  url: 'http://example.com/events/789',
                  description: 'A cool event',
                  start_date: '2016-08-10',
                  end_date: '2016-08-12',
                  venue: 'A cool place',
                  latitude: 65,
                  longitude: 65 })
    end
  end

end
