require 'test_helper'

class ContentProviderTest < Test::Unit::TestCase

  setup do
    @content_provider = Tess::API::ContentProvider.new(
        { title: 'Provider of Content',
          url: 'http://example.com/content_providers/789',
          keywords: ['cat', 'dog'] })

    @content_provider_full = Tess::API::ContentProvider.new(
        { title: 'Kontent King',
          url: 'http://example.com/content_providers/789',
          image_url: 'http://example.com/images/content_p.png',
          description: 'Hey!',
          content_provider_type: 'anything?',
          node_name: 'Francis',
          keywords: ['cat', 'dog'],
          contact: 'Jane Smith' })

    @content_provider_to_be_created = Tess::API::ContentProvider.new(
        { title: 'Provider of Content',
          url: 'http://example.com/content_providers/789',
          keywords: ['content', 'wow']
        })

    @existing_content_provider = Tess::API::ContentProvider.new(
        { title: 'Now is the winter of our content',
          url: 'http://example.com/content_providers/winter',
        })

    @non_existing_content_provider = Tess::API::ContentProvider.new(
        { title: 'Fresh-off-the-grill Content',
          url: 'http://example.com/content_providers/bbq',
          keywords: ['bbq', 'steak']
        })

    @content_provider_to_be_updated = Tess::API::ContentProvider.new(
        { id: 8,
          title: 'Re-branded Content Provider',
          keywords: ['hip', '#hashtag']
        })

    @content_provider_with_missing_fields = Tess::API::ContentProvider.new(
        { title: '',
          url: '',
        })

    @not_found_content_provider = Tess::API::ContentProvider.new(
        { id: 404040404,
          title: 'I will return a 404 or something',
          url: 'http://example.com/content_providers/404',
        })

    @bad_response_content_provider = Tess::API::ContentProvider.new(
        { title: 'I will return a 500 or something',
          url: 'http://example.com/content_providers/500',
        })
  end

  test 'can initialize a content provider' do
    assert_nothing_raised do
      Tess::API::ContentProvider.new({ title: 'Provider of Content',
                            url: 'http://example.com/content_providers/789',
                            keywords: ['cat', 'dog'] })
    end
  end

  test 'can get/set all attributes' do
    c = @content_provider_full

    assert_equal 'Kontent King', c.title
    c.title = 'Hello'
    assert_equal 'Hello', c.title

    assert_equal 'http://example.com/content_providers/789', c.url
    c.url = 'http://example.com/content_providers/456'
    assert_equal 'http://example.com/content_providers/456', c.url

    assert_equal 'http://example.com/images/content_p.png', c.image_url
    c.image_url = 'http://example.com/images/me.png'
    assert_equal 'http://example.com/images/me.png', c.image_url

    assert_equal 'Hey!', c.description
    c.description = 'What up, G?'
    assert_equal 'What up, G?', c.description

    assert_equal 'anything?', c.content_provider_type
    c.content_provider_type = Tess::API::ContentProvider::PROVIDER_TYPE[:PORTAL]
    assert_equal Tess::API::ContentProvider::PROVIDER_TYPE[:PORTAL], c.content_provider_type

    assert_equal 'Francis', c.node_name
    c.node_name = Tess::API::Node::NODE_NAMES[:CZ]
    assert_equal Tess::API::Node::NODE_NAMES[:CZ], c.node_name

    assert_equal ['cat', 'dog'], c.keywords
    c.keywords = ['hamster']
    assert_equal ['hamster'], c.keywords

    assert_equal 'Jane Smith', c.contact
    c.contact = 'Robert Smith'
    assert_equal 'Robert Smith', c.contact

    dump = c.dump
    parsed_json = JSON.parse(c.to_json)

    [:title, :url, :image_url, :description, :id, :content_provider_type, :node_name, :keywords, :contact].each do |attr|
      assert_equal c.send(attr), c[attr.to_s], "Unexpected value of '#{attr}' for content provider when using []"
      assert_equal c.send(attr), dump[attr.to_s], "Unexpected value of '#{attr}' for content provider in hash dump"
      assert_equal c.send(attr).to_s, parsed_json[attr.to_s].to_s, "Unexpected value of '#{attr}' for content provider in JSON"
    end
  end

  test 'can set CV-using fields with symbols or literals' do
    cp = Tess::API::ContentProvider.new({ content_provider_type: :organisation, node_name: :CZ })

    assert_equal Tess::API::ContentProvider::PROVIDER_TYPE[:organisation], cp.content_provider_type
    assert_equal Tess::API::Node::NODE_NAMES[:CZ], cp.node_name

    cp = Tess::API::ContentProvider.new({ content_provider_type: Tess::API::ContentProvider::PROVIDER_TYPE[:organisation],
                                          node_name: Tess::API::Node::NODE_NAMES[:CZ] })

    assert_equal Tess::API::ContentProvider::PROVIDER_TYPE[:organisation], cp.content_provider_type
    assert_equal Tess::API::Node::NODE_NAMES[:CZ], cp.node_name
  end

  test 'can dump content provider as hash' do
    hash = @content_provider.dump

    assert_equal 'Provider of Content', hash['title']
    assert_include hash['keywords'], 'dog'
    assert_equal hash['content_provider_type'], Tess::API::ContentProvider::PROVIDER_TYPE[:organisation]
  end

  test 'can dump content provider as JSON' do
    json = @content_provider.to_json
    parsed = nil

    assert_nothing_raised do
      parsed = JSON.parse(json)
    end

    assert_equal 'Provider of Content', parsed['title']
    assert_include parsed['keywords'], 'dog'
    assert_equal parsed['content_provider_type'], Tess::API::ContentProvider::PROVIDER_TYPE[:organisation]
  end


  test 'can create a content provider' do
    VCR.use_cassette('new_content_provider_upload') do
      res = @content_provider_to_be_created.create
      assert res['id'].to_i > 0
      assert_equal 'Provider of Content', res['title']
    end
  end

  test 'can check an content provider exists' do
    VCR.use_cassette('check_existing_content_provider') do
      assert @existing_content_provider.exists?
    end

    VCR.use_cassette('check_non_existing_content_provider') do
      refute @non_existing_content_provider.exists?
    end
  end

  test 'can update an content provider' do
    VCR.use_cassette('content_provider_update') do
      res = @content_provider_to_be_updated.update
      assert_equal 'Re-branded Content Provider', res['title']
      assert_includes res['keywords'], 'hip'
      assert_includes res['keywords'], '#hashtag'
    end
  end

  test 'can create or update an content provider' do
    id = nil

    VCR.use_cassette('create_or_update_content_provider_create') do
      res = @non_existing_content_provider.create_or_update
      assert_not_nil res['id']
      id = res['id']
    end

    @non_existing_content_provider.title = 'Changed title'
    VCR.use_cassette('create_or_update_content_provider_update') do
      res = @non_existing_content_provider.create_or_update
      assert_equal id, res['id']
      assert_equal 'Changed title', res['title']
    end
  end

  test 'can find or create a content provider' do
    refute @existing_content_provider.id
    VCR.use_cassette('check_existing_content_provider') do
      @existing_content_provider.find_or_create
      assert @existing_content_provider.id
    end

    refute @non_existing_content_provider.id
    VCR.use_cassette('create_or_update_content_provider_create') do
      @non_existing_content_provider.find_or_create
      assert @non_existing_content_provider.id
    end
  end

  test 'stores errors messages on bad create' do
    VCR.use_cassette('missing_fields_content_provider_create_response') do
      res = @content_provider_with_missing_fields.create
      assert res['errors']['title'].any?
      assert res['errors']['url'].any?
    end
  end

  test 'stores 505 exception message on bad create' do
    VCR.use_cassette('bad_content_provider_create_response') do
      res = @bad_response_content_provider.create
      assert_equal 'RestClient::InternalServerError: 500 Internal Server Error', res['errors']['exception']
    end
  end

  test 'stores 404 exception message on bad update' do
    VCR.use_cassette('bad_content_provider_update_response') do
      res = @not_found_content_provider.update
      assert_equal 'RestClient::NotFound: 404 Not Found', res['errors']['exception']
    end
  end
end
