require 'test_helper'

class MaterialTest < Test::Unit::TestCase

  setup do
    @material = Material.new({ content_provider_id: 123,
                               title: 'A new material',
                               url: 'http://example.com/materials/789',
                               short_description: 'A cool material',
                               long_description: 'A cooooooool material',
                               remote_created_date: '2016-08-10',
                               keywords: ['dog', 'cat'],
                               licence: 'GPL-3.0' })

    @material_full = Material.new({ id: 1,
                                    title: 'Interesting Material',
                                    url: 'http://example.com/materials/123',
                                    short_description: 'Super interesting',
                                    long_description: 'Super duper interesting',
                                    doi: '10.5072/doi/123',
                                    remote_created_date: '2016-02-01',
                                    remote_updated_date: '2016-02-06',
                                    package_ids: [1,2],
                                    content_provider_id: 1,
                                    keywords: ['interesting', 'material'],
                                    scientific_topic_names: ['Proteins', 'Metabolites'],
                                    licence: 'CC-BY-4.0',
                                    difficulty_level: ['easy'],
                                    contributors: ['Dave', 'Steve'],
                                    authors: ['Davina', 'Stacy'],
                                    target_audience: ['guys', 'gals'],
                                    node_ids: [8,9],
                                    external_resources_attributes: [{ title: 'A resource', url: 'http://www.example.com/resources/2'}] })
  end

  test 'can initialize a material' do
    assert_nothing_raised do
      Material.new({ content_provider_id: 123,
                     title: 'A new material',
                     url: 'http://example.com/materials/789',
                     short_description: 'A cool material',
                     long_description: 'A cooooooool material',
                     remote_created_date: '2016-08-10',
                     keywords: ['dog', 'cat'],
                     licence: 'GPL-3.0' })
    end
  end

  test 'can get/set all attributes' do
    m = @material_full

    assert_equal 1, m.id
    m.id = 2
    assert_equal 2, m.id

    assert_equal 'Interesting Material', m.title
    m.title = 'Really Interesting Material'
    assert_equal 'Really Interesting Material', m.title

    assert_equal 'http://example.com/materials/123', m.url
    m.url = 'http://example.com/materials/456'
    assert_equal 'http://example.com/materials/456', m.url

    assert_equal 'Super interesting', m.short_description
    m.short_description = 'So interesting'
    assert_equal 'So interesting', m.short_description

    assert_equal 'Super duper interesting', m.long_description
    m.long_description = 'Sooooooo interesting'
    assert_equal 'Sooooooo interesting', m.long_description

    assert_equal '10.5072/doi/123', m.doi
    m.doi = '10.5072/doi/456'
    assert_equal '10.5072/doi/456', m.doi

    assert_equal '2016-02-01', m.remote_created_date
    m.remote_created_date = '2016-03-01'
    assert_equal '2016-03-01', m.remote_created_date

    assert_equal '2016-02-06', m.remote_updated_date
    m.remote_updated_date = '2016-03-06'
    assert_equal '2016-03-06', m.remote_updated_date

    assert_equal [1,2], m.package_ids
    m.package_ids = [3,4]
    assert_equal [3,4], m.package_ids

    assert_equal 1, m.content_provider_id
    m.content_provider_id = 2
    assert_equal 2, m.content_provider_id

    assert_equal ['interesting', 'material'], m.keywords
    m.keywords = ['cool', 'material']
    assert_equal ['cool', 'material'], m.keywords

    assert_equal ['Proteins', 'Metabolites'], m.scientific_topic_names
    m.scientific_topic_names = ['Alignment', 'Phyologeny']
    assert_equal ['Alignment', 'Phyologeny'], m.scientific_topic_names

    assert_equal 'CC-BY-4.0', m.licence
    m.licence = 'CC-BY-SA-4.0'
    assert_equal 'CC-BY-SA-4.0', m.licence

    assert_equal ['easy'], m.difficulty_level
    m.difficulty_level = ['hard']
    assert_equal ['hard'], m.difficulty_level

    assert_equal ['Dave', 'Steve'], m.contributors
    m.contributors = ['Dave-o', 'Steve-o']
    assert_equal ['Dave-o', 'Steve-o'], m.contributors

    assert_equal ['Davina', 'Stacy'], m.authors
    m.authors = ['Sandra']
    assert_equal ['Sandra'], m.authors

    assert_equal ['guys', 'gals'], m.target_audience
    m.target_audience = ['guys', 'gals', 'dogs', 'cats']
    assert_equal ['guys', 'gals', 'dogs', 'cats'], m.target_audience

    assert_equal [8,9], m.node_ids
    m.node_ids = [10]
    assert_equal [10], m.node_ids

    assert_equal 'A resource', m.external_resources_attributes.first[:title]
    assert_equal 'http://www.example.com/resources/2', m.external_resources_attributes.first[:url]
    m.external_resources_attributes = [{ title: 'Better resource', url: 'http://www.example.com/resources/4'}]
    assert_equal 'Better resource', m.external_resources_attributes.first[:title]
    assert_equal 'http://www.example.com/resources/4', m.external_resources_attributes.first[:url]
  end

  test 'can dump material as hash' do
    hash = new_material.dump

    assert_equal 123, hash['content_provider_id']
    assert_include hash['keywords'], 'dog'
    assert_equal hash['remote_created_date'], '2016-08-10'
    assert_equal hash['scraper_record'], true
  end


  test 'can dump material as JSON' do
    json = new_material.to_json
    parsed = nil

    assert_nothing_raised do
      parsed = JSON.parse(json)
    end

    assert_equal 123, parsed['content_provider_id']
    assert_include parsed['keywords'], 'dog'
    assert_equal parsed['remote_created_date'], '2016-08-10'
    assert_equal parsed['scraper_record'], true
  end

  private

  def new_material
    Material.new({ content_provider_id: 123,
                   title: 'A new material',
                   url: 'http://example.com/materials/789',
                   short_description: 'A cool material',
                   long_description: 'A cooooooool material',
                   remote_created_date: '2016-08-10',
                   keywords: ['dog', 'cat'],
                   licence: 'GPL-3.0',
                 })
  end

end
