require 'test_helper'

class ContentProviderTest < Test::Unit::TestCase

  setup do
    @content_provider = ContentProvider.new({ title: 'Provider of Content',
                                              url: 'http://example.com/content_providers/789',
                                              keywords: ['cat', 'dog'] })

    @content_provider_full = ContentProvider.new({ title: 'Kontent King',
                                                   url: 'http://example.com/content_providers/789',
                                                   image_url: 'http://example.com/images/content_p.png',
                                                   description: 'Hey!',
                                                   content_provider_type: 'anything?',
                                                   node: 'Francis',
                                                   keywords: ['cat', 'dog'] })
  end

  test 'can initialize a content provider' do
    assert_nothing_raised do
      ContentProvider.new({ title: 'Provider of Content',
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
    c.content_provider_type = ContentProvider::PROVIDER_TYPE[:PORTAL]
    assert_equal ContentProvider::PROVIDER_TYPE[:PORTAL], c.content_provider_type

    assert_equal 'Francis', c.node_name
    c.node_name = Node::NODE_NAMES[:CZ]
    assert_equal Node::NODE_NAMES[:CZ], c.node_name

    assert_equal ['cat', 'dog'], c.keywords
    c.keywords = ['hamster']
    assert_equal ['hamster'], c.keywords
  end

  test 'can dump content provider as hash' do
    hash = @content_provider.dump

    assert_equal 'Provider of Content', hash['title']
    assert_include hash['keywords'], 'dog'
    assert_equal hash['content_provider_type'], ContentProvider::PROVIDER_TYPE[:ORGANISATION]
  end


  test 'can dump content provider as JSON' do
    json = @content_provider.to_json
    parsed = nil

    assert_nothing_raised do
      parsed = JSON.parse(json)
    end

    assert_equal 'Provider of Content', parsed['title']
    assert_include parsed['keywords'], 'dog'
    assert_equal parsed['content_provider_type'], ContentProvider::PROVIDER_TYPE[:ORGANISATION]
  end

  private

  def new_content_provider
    ContentProvider.new({ title: 'Provider of Content',
                          url: 'http://example.com/content_providers/789',
                          keywords: ['cat', 'dog'] })
  end

end
