require 'test_helper'

class EventTest < Test::Unit::TestCase

  setup do
    @event = Event.new(
        { content_provider_id: 123,
                         title: 'A new event',
                         url: 'http://example.com/events/789',
                         description: 'A cool event',
                         start_date: '2016-08-10',
                         end_date: '2016-08-12',
                         venue: 'A cool place',
                         keywords: ['dog', 'cat'],
                         latitude: 65,
                         longitude: 65 })

    @event_full = Event.new(
        { id: 1,
                              external_id: 456,
                              content_provider_id: 123,
                              title: 'Big Event',
                              subtitle: 'Really big',
                              url: 'http://example.com/events/abc',
                              organizer: 'Org',
                              description: 'Hello world',
                              scientific_topic_names: ['topic1', 'topic2'],
                              event_types: [Event::EVENT_TYPE[:awards_and_prizegivings]],
                              keywords: ['abc'],
                              start_date: '2016-10-04',
                              end_date: '2016-10-05',
                              sponsor: 'Bill Gates',
                              online: true,
                              for_profit: true,
                              venue: 'A place',
                              city: 'Manchester',
                              county: 'Lancashire',
                              country: 'United Kingdom',
                              postcode: 'M13 9PL',
                              latitude: 50,
                              longitude: 40,
                              package_ids: [1,2],
                              node_ids: [3,4],
                              target_audience: ['people'],
                              eligibility: ['interested'],
                              host_institutions: ['uni1', 'uni2'],
                              capacity: 10,
                              contact: 'Bill Gates (bg@example.com)',
                              external_resources_attributes: [{ title: 'A resource', url: 'http://www.example.com/resources/2'}]
                            })

    @event_to_be_created = Event.new(
        { content_provider_id: 1,
          title: 'A new event',
          url: 'http://example.com/events/789',
          description: 'A cool event',
          start_date: '2016-10-10',
          end_date: '2016-10-12',
          venue: 'A cool place',
          keywords: ['dog', 'cat'],
          latitude: 53.467324,
          longitude: -2.234101 })

    @existing_event = Event.new(
        { content_provider_id: 1,
          title: 'An Existing Event',
          url: 'http://example.com/events/existing',
          description: 'Already exists',
          start_date: '2016-10-11',
          end_date: '2016-10-13',
          venue: 'A place',
          keywords: ['existing'],
          latitude: 53.467324,
          longitude: -2.234101 })
    @non_existing_event = Event.new(
        { content_provider_id: 1,
          title: 'Cutting-edge Event',
          url: 'http://example.com/events/cutting-edge',
          description: "Possibly doesn't exist yet",
          start_date: '2016-10-13',
          end_date: '2016-10-15',
          venue: 'A place',
          keywords: ['novel'],
          latitude: 53.467324,
          longitude: -2.234101 })

    @event_to_be_updated = Event.new(
        { id: 24,
          title: 'Rad, new title',
          keywords: ['snake']
        })


    @event_with_new_content_provider = Event.new(
        {
            content_provider: ContentProvider.new(
                { title: 'Fresh-off-the-grill Content',
                  url: 'http://example.com/content_providers/bbq',
                  keywords: ['bbq', 'steak']
                }),
            title: 'A new event with an existing content provider',
            url: 'http://example.com/events/nmwecp',
            start_date: '2016-10-10',
            end_date: '2016-10-12',
            venue: 'A cool place',
            keywords: ['dog', 'cat']
        })

    @event_with_existing_content_provider = Event.new(
        {
            content_provider: ContentProvider.new(
                { title: 'Now is the winter of our content',
                  url: 'http://example.com/content_providers/winter',
                }),
            title: 'A new event with a new content provider',
            url: 'http://example.com/events/nmwncp',
            start_date: '2016-10-10',
            end_date: '2016-10-12',
            venue: 'A very cool place',
            keywords: ['dog', 'cat']
        })
  end

  test 'can initialize an event' do
    assert_nothing_raised do
      Event.new({ content_provider_id: 123,
                  title: 'A new event',
                  url: 'http://example.com/events/789',
                  description: 'A cool event',
                  start_date: '2016-08-10',
                  end_date: '2016-08-12',
                  venue: 'A cool place',
                  keywords: ['dog', 'cat'],
                  latitude: 65,
                  longitude: 65 })
    end
  end

  test 'can get/set all attributes' do
    e = @event_full

    assert_equal 1, e.id
    e.id = 2
    assert_equal 2, e.id

    assert_equal 456, e.external_id
    e.external_id = 777
    assert_equal 777, e.external_id

    assert_equal 123, e.content_provider_id
    e.content_provider_id = 999
    assert_equal 999, e.content_provider_id

    assert_equal 'Big Event', e.title
    e.title = 'Really Big Event'
    assert_equal 'Really Big Event', e.title

    assert_equal 'Really big', e.subtitle
    e.subtitle = 'Super big'
    assert_equal 'Super big', e.subtitle

    assert_equal 'http://example.com/events/abc', e.url
    e.url = 'http://example.com/events/abcd'
    assert_equal 'http://example.com/events/abcd', e.url

    assert_equal 'Org', e.organizer
    e.organizer = 'Anizer'
    assert_equal 'Anizer', e.organizer

    assert_equal 'Hello world', e.description
    e.description = 'Goodbye, cruel world'
    assert_equal 'Goodbye, cruel world', e.description

    assert_equal ['topic1', 'topic2'], e.scientific_topic_names
    e.scientific_topic_names = ['topic3', 'topic4']
    assert_equal ['topic3', 'topic4'], e.scientific_topic_names

    assert_equal [Event::EVENT_TYPE[:awards_and_prizegivings]], e.event_types
    e.event_types = [Event::EVENT_TYPE[:meetings_and_conferences]]
    assert_equal [Event::EVENT_TYPE[:meetings_and_conferences]], e.event_types

    assert_equal ['abc'], e.keywords
    e.keywords = ['fun']
    assert_equal ['fun'], e.keywords

    assert_equal '2016-10-04', e.start
    e.start = '2016-10-05'
    assert_equal '2016-10-05', e.start

    assert_equal '2016-10-05', e.end
    e.end = '2016-10-07'
    assert_equal '2016-10-07', e.end

    assert_equal 'Bill Gates', e.sponsor
    e.sponsor = 'Gill Bates'
    assert_equal 'Gill Bates', e.sponsor

    assert_equal true, e.online
    e.online = false
    assert_equal false, e.online

    assert_equal true, e.for_profit
    e.for_profit = false
    assert_equal false, e.for_profit

    assert_equal 'A place', e.venue
    e.venue = 'Somewhere else'
    assert_equal 'Somewhere else', e.venue

    assert_equal 'Manchester', e.city
    e.city = 'Sheffield'
    assert_equal 'Sheffield', e.city

    assert_equal 'Lancashire', e.county
    e.county = 'South Yorkshire'
    assert_equal 'South Yorkshire', e.county

    assert_equal 'United Kingdom', e.country
    e.country = 'UK'
    assert_equal 'UK', e.country

    assert_equal 'M13 9PL', e.postcode
    e.postcode = 'S2 4LP'
    assert_equal 'S2 4LP', e.postcode

    assert_equal 50, e.latitude
    e.latitude = 70
    assert_equal 70, e.latitude

    assert_equal 40, e.longitude
    e.longitude = 60
    assert_equal 60, e.longitude

    assert_equal [1,2], e.package_ids
    e.package_ids = [3,4,5]
    assert_equal [3,4,5], e.package_ids

    assert_equal [3,4], e.node_ids
    e.node_ids = []
    assert_equal [], e.node_ids

    assert_equal ['people'], e.target_audience
    e.target_audience = ['people','animals']
    assert_equal ['people', 'animals'], e.target_audience

    assert_equal ['interested'], e.eligibility
    e.eligibility = ['anyone']
    assert_equal ['anyone'], e.eligibility

    assert_equal ['uni1', 'uni2'], e.host_institutions
    e.host_institutions = ['uni3']
    assert_equal ['uni3'], e.host_institutions

    assert_equal 10, e.capacity
    e.capacity = 20
    assert_equal 20, e.capacity

    assert_equal 'Bill Gates (bg@example.com)', e.contact
    e.contact = 'Gill Bates (gb@example.com)'
    assert_equal 'Gill Bates (gb@example.com)', e.contact

    assert_equal 'A resource', e.external_resources_attributes.first[:title]
    assert_equal 'http://www.example.com/resources/2', e.external_resources_attributes.first[:url]
    e.external_resources_attributes = [{ title: 'Another resource', url: 'http://www.example.com/resources/3'}]
    assert_equal 'Another resource', e.external_resources_attributes.first[:title]
    assert_equal 'http://www.example.com/resources/3', e.external_resources_attributes.first[:url]

    dump = e.dump
    parsed_json = JSON.parse(e.to_json)

    [:id, :external_id, :content_provider_id, :title, :subtitle, :url, :organizer, :last_scraped,
     :scraper_record, :description, :scientific_topic_names, :event_types,
     :keywords, :start, :end, :sponsor, :online, :for_profit, :venue,
     :city, :county, :country, :postcode, :latitude, :longitude,
     :package_ids, :node_ids, :target_audience, :eligibility,
     :host_institutions, :capacity, :contact].each do |attr|
      assert_equal e.send(attr), e[attr.to_s], "Unexpected value of '#{attr}' for event when using []"
      assert_equal e.send(attr), dump[attr.to_s], "Unexpected value of '#{attr}' for event in hash dump"
      assert_equal e.send(attr).to_s, parsed_json[attr.to_s].to_s, "Unexpected value of '#{attr}' for event in JSON"
    end
  end

  test 'can dump event as hash' do
    hash = @event.dump

    assert_equal 123, hash['content_provider_id']
    assert_include hash['keywords'], 'dog'
    assert_include hash['end'], '2016-08-12'
  end


  test 'can dump event as JSON' do
    json = @event.to_json
    parsed = nil

    assert_nothing_raised do
      parsed = JSON.parse(json)
    end

    assert_equal 123, parsed['content_provider_id']
    assert_include parsed['keywords'], 'dog'
    assert_include parsed['end'], '2016-08-12'
  end


  test 'can create an event' do
    VCR.use_cassette('new_event_upload') do
      res = @event_to_be_created.create
      assert res['id'].to_i > 0
      assert_equal 'A new event', res['title']
    end
  end

  test 'can check an event exists' do
    VCR.use_cassette('check_existing_event') do
      assert @existing_event.exists?
    end

    VCR.use_cassette('check_non_existing_event') do
      refute @non_existing_event.exists?
    end
  end

  test 'can update an event' do
    VCR.use_cassette('event_update') do
      res = @event_to_be_updated.update
      assert_equal 'Rad, new title', res['title']
      assert_equal ['snake'], res['keywords']
    end
  end

  test 'can create or update an event' do
    id = nil

    VCR.use_cassette('create_or_update_event_create') do
      res = @non_existing_event.create_or_update
      assert_not_nil res['id']
      id = res['id']
    end

    @non_existing_event.title = 'Changed title'
    VCR.use_cassette('create_or_update_event_update') do
      res = @non_existing_event.create_or_update
      assert_equal id, res['id']
      assert_equal 'Changed title', res['title']
    end
  end

  test 'can create a content provider while creating event' do
    VCR.use_cassette('check_non_existing_content_provider') do
      VCR.use_cassette('create_or_update_content_provider_create') do
        VCR.use_cassette('create_new_event_with_new_content_provider') do
          res = @event_with_new_content_provider.create
          assert res['id'].to_i > 0
          assert res.content_provider.id > 0
          assert res.content_provider_id > 0
        end
      end
    end
  end

  test 'does not duplicate existing content provider while creating event' do
    VCR.use_cassette('check_existing_content_provider') do
      VCR.use_cassette('create_or_update_content_provider_update') do
        VCR.use_cassette('create_new_event_with_existing_content_provider') do
          res = @event_with_existing_content_provider.create
          assert res['id'].to_i > 0
          assert_equal 9, res.content_provider.id
          assert_equal 9, res.content_provider_id
        end
      end
    end
  end

  test 'does not create/update content provider while creating event if given ID' do
    @event_with_existing_content_provider.content_provider = nil
    @event_with_existing_content_provider.content_provider_id = 9
    VCR.use_cassette('check_existing_content_provider') do
      VCR.use_cassette('create_new_event_with_existing_content_provider') do
        res = @event_with_existing_content_provider.create
        assert res['id'].to_i > 0
        assert_equal 9, res.content_provider_id
      end
    end

    @event_with_existing_content_provider.content_provider = ContentProvider.new(id: 9)
    @event_with_existing_content_provider.content_provider_id = nil
    VCR.use_cassette('check_existing_content_provider') do
      VCR.use_cassette('create_new_event_with_existing_content_provider') do
        res = @event_with_existing_content_provider.create
        assert res['id'].to_i > 0
        assert_equal 9, res.content_provider_id
      end
    end
  end

end
