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

    @material_to_be_created = Material.new(
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

    @material_with_new_content_provider = Material.new(
        {
            content_provider: ContentProvider.new(
                { title: 'Fresh-off-the-grill Content',
                  url: 'http://example.com/content_providers/bbq',
                  keywords: ['bbq', 'steak']
                }),
            title: 'A new material with an existing content provider',
            url: 'http://example.com/materials/nmwecp',
            short_description: 'A cool material',
            long_description: 'A cooooooool material',
            remote_created_date: '2016-08-10',
            keywords: ['dog', 'cat'],
            licence: 'GPL-3.0'
        })

    @material_with_existing_content_provider = Material.new(
        {
            content_provider: ContentProvider.new(
                { title: 'Now is the winter of our content',
                  url: 'http://example.com/content_providers/winter',
                }),
            title: 'A new material with a new content provider',
            url: 'http://example.com/materials/nmwncp',
            short_description: 'A cool material',
            long_description: 'A cooooooool material',
            remote_created_date: '2016-08-10',
            keywords: ['dog', 'cat'],
            licence: 'GPL-3.0'
        })
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

    dump = m.dump
    parsed_json = JSON.parse(m.to_json)

    [:id, :title, :url, :short_description, :long_description, :doi,:last_scraped, :scraper_record,
     :remote_created_date,  :remote_updated_date, :package_ids, :content_provider_id,
     :keywords, :scientific_topic_names, :licence, :difficulty_level,
     :contributors, :authors, :target_audience, :node_ids].each do |attr|
      assert_equal m.send(attr), m[attr.to_s], "Unexpected value of '#{attr}' for material when using []"
      assert_equal m.send(attr), dump[attr.to_s], "Unexpected value of '#{attr}' for material in hash dump"
      assert_equal m.send(attr).to_s, parsed_json[attr.to_s].to_s, "Unexpected value of '#{attr}' for material in JSON"
    end
  end

  test 'can dump material as hash' do
    hash = @material.dump

    assert_equal 123, hash['content_provider_id']
    assert_include hash['keywords'], 'dog'
    assert_equal hash['remote_created_date'], '2016-08-10'
    assert_equal hash['scraper_record'], true
  end

  test 'can dump material as JSON' do
    json = @material.to_json
    parsed = nil

    assert_nothing_raised do
      parsed = JSON.parse(json)
    end

    assert_equal 123, parsed['content_provider_id']
    assert_include parsed['keywords'], 'dog'
    assert_equal parsed['remote_created_date'], '2016-08-10'
    assert_equal parsed['scraper_record'], true
  end

  test 'can create a material' do
    VCR.use_cassette('new_material_upload') do
      res = @material_to_be_created.create
      assert res['id'].to_i > 0
      assert_equal 'A new material', res['title']
    end
  end

  test 'can check a material exists' do
    VCR.use_cassette('check_existing_material') do
      assert @existing_material.exists?
    end

    VCR.use_cassette('check_non_existing_material') do
      refute @non_existing_material.exists?
    end
  end

  test 'can update a material' do
    VCR.use_cassette('material_update') do
      res = @material_to_be_updated.update
      assert_equal 'Adjusted title', res['title']
      assert_equal ['bear'], res['keywords']
    end
  end

  test 'can create or update a material' do
    id = nil

    VCR.use_cassette('create_or_update_material_create') do
      res = @non_existing_material.create_or_update
      assert_not_nil res['id']
      id = res['id']
    end

    @non_existing_material.title = 'Changed title'
    VCR.use_cassette('create_or_update_material_update') do
      res = @non_existing_material.create_or_update
      assert_equal id, res['id']
      assert_equal 'Changed title', res['title']
    end
  end

  test 'can create a content provider while creating material' do
    VCR.use_cassette('check_non_existing_content_provider') do
      VCR.use_cassette('create_or_update_content_provider_create') do
        VCR.use_cassette('create_new_material_with_new_content_provider') do
          res = @material_with_new_content_provider.create
          assert res['id'].to_i > 0
          assert res.content_provider.id > 0
          assert res.content_provider_id > 0
        end
      end
    end
  end

  test 'does not duplicate existing content provider while creating material' do
    VCR.use_cassette('check_existing_content_provider') do
      VCR.use_cassette('create_or_update_content_provider_update') do
        VCR.use_cassette('create_new_material_with_existing_content_provider') do
          res = @material_with_existing_content_provider.create
          assert res['id'].to_i > 0
          assert_equal 9, res.content_provider.id
          assert_equal 9, res.content_provider_id
        end
      end
    end
  end

  test 'does not create/update content provider while creating material if given ID' do
    @material_with_existing_content_provider.content_provider = nil
    @material_with_existing_content_provider.content_provider_id = 9
    VCR.use_cassette('check_existing_content_provider') do
      VCR.use_cassette('create_new_material_with_existing_content_provider') do
        res = @material_with_existing_content_provider.create
        assert res['id'].to_i > 0
        assert_equal 9, res.content_provider_id
      end
    end

    @material_with_existing_content_provider.content_provider = ContentProvider.new(id: 9)
    @material_with_existing_content_provider.content_provider_id = nil
    VCR.use_cassette('check_existing_content_provider') do
      VCR.use_cassette('create_new_material_with_existing_content_provider') do
        res = @material_with_existing_content_provider.create
        assert res['id'].to_i > 0
        assert_equal 9, res.content_provider_id
      end
    end
  end

end
