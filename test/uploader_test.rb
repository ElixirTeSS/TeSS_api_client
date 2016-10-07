require 'test_helper'

class UploaderTest < Test::Unit::TestCase

  setup do
    @new_material = Material.new(
        {
            content_provider_id: 1,
            title: 'A new material',
            url: 'http://example.com/materials/789',
            short_description: 'A cool material',
            long_description: 'A cooooooool material',
            remote_created_date: '2016-08-10',
            keywords: ['dog', 'cat'],
            licence: 'GPL-3.0'
        })

    @existing_material = Material.new(
        {
            content_provider_id: 1,
            title: 'An existing material',
            url: 'http://example.com/materials/existing',
            keywords: ['dog', 'cat'],
            short_description: 'a',
            licence: 'GPL-3.0'
        })

    @non_existing_material = Material.new(
        {
            content_provider_id: 1,
            title: 'An novel material',
            short_description: 'a',
            url: 'http://example.com/materials/123'
        })

    @material_to_be_updated = Material.new(
        {
            id: 170,
            title: 'Adjusted title',
            keywords: ['bear']
        })

    @new_event = Event.new(
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

    @new_content_provider = ContentProvider.new(
        { title: 'Provider of Content',
          url: 'http://example.com/content_providers/789',
          keywords: ['content', 'wow']
        })

    @existing_content_provider = ContentProvider.new(
        { title: 'Now is the winter of our content',
          url: 'http://example.com/content_providers/winter',
        })

    @non_existing_content_provider = ContentProvider.new(
        { title: 'Fresh-off-the-grill Content',
          url: 'http://example.com/content_providers/bbq',
          keywords: ['bbq', 'steak']
        })

    @content_provider_to_be_updated = ContentProvider.new(
        { id: 8,
          title: 'Re-branded Content Provider',
          keywords: ['hip', '#hashtag']
        })
  end

  test 'can create a material' do
    VCR.use_cassette('new_material_upload') do
      res = Uploader.create_material(@new_material)
      assert res['id'].to_i > 0
      assert_equal 'A new material', res['title']
    end
  end

  test 'can check a material exists' do
    VCR.use_cassette('check_existing_material') do
      res = Uploader.check_material(@existing_material)
      assert_not_nil res['id']
    end

    VCR.use_cassette('check_non_existing_material') do
      res = Uploader.check_material(@non_existing_material)
      assert_nil res['id']
    end
  end

  test 'can update a material' do
    VCR.use_cassette('material_update') do
      res = Uploader.update_material(@material_to_be_updated)
      assert_equal 'Adjusted title', res['title']
      assert_equal ['bear'], res['keywords']
    end
  end

  test 'can create or update a material' do
    id = nil

    VCR.use_cassette('create_or_update_material_create') do
      res = Uploader.create_or_update_material(@non_existing_material)
      assert_not_nil res['id']
      id = res['id']
    end

    @non_existing_material.title = 'Changed title'
    assert_nil @non_existing_material.id, "ID should be nil, as we are relying on TeSS' check_exists method to find the existing material"
    VCR.use_cassette('create_or_update_material_update') do
      res = Uploader.create_or_update_material(@non_existing_material)
      assert_equal id, res['id']
      assert_equal 'Changed title', res['title']
    end
  end

  test 'can create an event' do
    VCR.use_cassette('new_event_upload') do
      res = Uploader.create_event(@new_event)
      assert res['id'].to_i > 0
      assert_equal 'A new event', res['title']
    end
  end

  test 'can check an event exists' do
    VCR.use_cassette('check_existing_event') do
      res = Uploader.check_event(@existing_event)
      assert_not_nil res['id']
    end

    VCR.use_cassette('check_non_existing_event') do
      res = Uploader.check_event(@non_existing_event)
      assert_nil res['id']
    end
  end

  test 'can update an event' do
    VCR.use_cassette('event_update') do
      res = Uploader.update_event(@event_to_be_updated)
      assert_equal 'Rad, new title', res['title']
      assert_equal ['snake'], res['keywords']
    end
  end

  test 'can create or update an event' do
    id = nil

    VCR.use_cassette('create_or_update_event_create') do
      res = Uploader.create_or_update_event(@non_existing_event)
      assert_not_nil res['id']
      id = res['id']
    end

    @non_existing_event.title = 'Changed title'
    assert_nil @non_existing_event.id, "ID should be nil, as we are relying on TeSS' check_exists method to find the existing event"
    VCR.use_cassette('create_or_update_event_update') do
      res = Uploader.create_or_update_event(@non_existing_event)
      assert_equal id, res['id']
      assert_equal 'Changed title', res['title']
    end
  end

  test 'can create a content provider' do
    VCR.use_cassette('new_content_provider_upload') do
      res = Uploader.create_content_provider(@new_content_provider)
      assert res['id'].to_i > 0
      assert_equal 'Provider of Content', res['title']
    end
  end

  test 'can check an content provider exists' do
    VCR.use_cassette('check_existing_content_provider') do
      res = Uploader.check_content_provider(@existing_content_provider)
      assert_not_nil res['id']
    end

    VCR.use_cassette('check_non_existing_content_provider') do
      res = Uploader.check_content_provider(@non_existing_content_provider)
      assert_nil res['id']
    end
  end

  test 'can update an content provider' do
    VCR.use_cassette('content_provider_update') do
      res = Uploader.update_content_provider(@content_provider_to_be_updated)
      assert_equal 'Re-branded Content Provider', res['title']
      assert_includes res['keywords'], 'hip'
      assert_includes res['keywords'], '#hashtag'
    end
  end

  test 'can create or update an content provider' do
    id = nil

    VCR.use_cassette('create_or_update_content_provider_create') do
      res = Uploader.create_or_update_content_provider(@non_existing_content_provider)
      assert_not_nil res['id']
      id = res['id']
    end

    @non_existing_content_provider.title = 'Changed title'
    assert_nil @non_existing_content_provider.id, "ID should be nil, as we are relying on TeSS' check_exists method to find the existing content provider"
    VCR.use_cassette('create_or_update_content_provider_update') do
      res = Uploader.create_or_update_content_provider(@non_existing_content_provider)
      assert_equal id, res['id']
      assert_equal 'Changed title', res['title']
    end
  end

end
