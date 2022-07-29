require 'test_helper'

class MaterialTest < Test::Unit::TestCase

  setup do
    @material = Tess::API::Material.new(
        { content_provider_id: 123,
          title: 'A new material',
          url: 'http://example.com/materials/789',
          description: 'A cool material',
          remote_created_date: '2016-08-10',
          resource_type: 'Video',
          keywords: ['dog', 'cat'],
          licence: 'GPL-3.0' })

    @material_full = Tess::API::Material.new(
        { id: 1,
          title: 'Interesting Material',
          url: 'http://example.com/materials/123',
          description: 'Super interesting',
          doi: '10.5072/doi/123',
          remote_created_date: '2016-02-01',
          remote_updated_date: '2016-02-06',
          collection_ids: [1,2],
          content_provider_id: 1,
          keywords: ['interesting', 'material'],
          scientific_topic_names: ['Proteins', 'Metabolites'],
          licence: 'CC-BY-4.0',
          difficulty_level: ['easy'],
          contributors: ['Dave', 'Steve'],
          authors: ['Davina', 'Stacy'],
          target_audience: ['guys', 'gals'],
          node_ids: [8,9],
          node_names: ['Greece', 'Israel'],
          external_resources_attributes: [{ title: 'A resource', url: 'http://www.example.com/resources/2'}],
          other_types: 'Podcast, White Paper',
          version: '1.0.4',
          status: 'active',
          date_created: '2021-06-12',
          date_modified: '2021-06-13',
          date_published: '2021-06-14',
          subsets: ['https://training.com/material/023/part-one', 'https://training.com/material/023/part-two'],
          prerequisites: 'Bring your enthusiasm',
          syllabus: "1. Overview\  2. The main part\  3. Summary",
          learning_objectives: "- Understand the new materials model\  - Apply the new material model",
          fields: ['Software Engineering','MATHEMATICS'],
          event_ids: [456],
        })

    @material_to_be_created = Tess::API::Material.new(
        { content_provider_id: 1,
          title: 'A new material',
          url: 'http://example.com/materials/789',
          description: 'A cool material',
          remote_created_date: '2016-08-10',
          keywords: ['dog', 'cat'],
          licence: 'GPL-3.0'
        })

    @existing_material = Tess::API::Material.new(
        { content_provider_id: 1,
          title: 'An existing material',
          url: 'http://example.com/materials/existing',
          keywords: ['dog', 'cat'],
          description: 'a',
          licence: 'GPL-3.0'
        })

    @non_existing_material = Tess::API::Material.new(
        { content_provider_id: 1,
          title: 'An novel material',
          description: 'a',
          url: 'http://example.com/materials/123'
        })

    @material_to_be_updated = Tess::API::Material.new(
        { id: 170,
          title: 'Adjusted title',
          keywords: ['bear']
        })

    @material_with_new_content_provider = Tess::API::Material.new(
        { content_provider: Tess::API::ContentProvider.new(
            { title: 'Fresh-off-the-grill Content',
              url: 'http://example.com/content_providers/bbq',
              keywords: ['bbq', 'steak']
            }),
          title: 'A new material with an existing content provider',
          url: 'http://example.com/materials/nmwecp',
          description: 'A cool material',
          remote_created_date: '2016-08-10',
          keywords: ['dog', 'cat'],
          licence: 'GPL-3.0'
        })

    @material_with_existing_content_provider = Tess::API::Material.new(
        { content_provider: Tess::API::ContentProvider.new(
            { title: 'Now is the winter of our content',
              url: 'http://example.com/content_providers/winter',
            }),
          title: 'A new material with a new content provider',
          url: 'http://example.com/materials/nmwncp',
          description: 'A cool material',
          remote_created_date: '2016-08-10',
          keywords: ['dog', 'cat'],
          licence: 'GPL-3.0'
        })

    @invalid_material = Tess::API::Material.new(
        { content_provider_id: 123,
          title: 'Missing field material',
          licence: 'GPL-3.0' })
  end

  test 'can initialize a material' do
    assert_nothing_raised do
      Tess::API::Material.new(
          { content_provider_id: 123,
                                title: 'A new material',
                                url: 'http://example.com/materials/789',
                                description: 'A cool material',
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

    assert_equal 'Super interesting', m.description
    m.description = 'So interesting'
    assert_equal 'So interesting', m.description

    assert_equal '10.5072/doi/123', m.doi
    m.doi = '10.5072/doi/456'
    assert_equal '10.5072/doi/456', m.doi

    assert_equal '2016-02-01', m.remote_created_date
    m.remote_created_date = '2016-03-01'
    assert_equal '2016-03-01', m.remote_created_date

    assert_equal '2016-02-06', m.remote_updated_date
    m.remote_updated_date = '2016-03-06'
    assert_equal '2016-03-06', m.remote_updated_date

    assert_equal [1,2], m.collection_ids
    m.collection_ids = [3,4]
    assert_equal [3,4], m.collection_ids

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

    assert_equal ['Greece','Israel'], m.node_names
    m.node_names = ['Italy']
    assert_equal ['Italy'], m.node_names

    assert_equal 'A resource', m.external_resources_attributes.first[:title]
    assert_equal 'http://www.example.com/resources/2', m.external_resources_attributes.first[:url]
    m.external_resources_attributes = [{ title: 'Better resource', url: 'http://www.example.com/resources/4'}]
    assert_equal 'Better resource', m.external_resources_attributes.first[:title]
    assert_equal 'http://www.example.com/resources/4', m.external_resources_attributes.first[:url]

    assert_equal 'Podcast, White Paper', m.other_types
    m.other_types = 'Another Type'
    assert_equal 'Another Type', m.other_types

    assert_equal '1.0.4', m.version
    m.version = '1.1.0'
    assert_equal '1.1.0', m.version

    assert_equal 'active', m.status
    m.status = 'development'
    assert_equal 'development', m.status

    assert_equal '2021-06-12', m.date_created
    m.date_created = '2021-06-13'
    assert_equal '2021-06-13', m.date_created

    assert_equal '2021-06-13', m.date_modified
    m.date_modified = '2021-06-14'
    assert_equal '2021-06-14', m.date_modified

    assert_equal '2021-06-14', m.date_published
    m.date_published = '2021-06-15'
    assert_equal '2021-06-15', m.date_published

    assert_equal ['https://training.com/material/023/part-one', 'https://training.com/material/023/part-two'], m.subsets
    m.subsets = ['https://training.com/material/023/part-two']
    assert_equal ['https://training.com/material/023/part-two'], m.subsets

    assert_equal 'Bring your enthusiasm', m.prerequisites
    m.prerequisites = 'Foo'
    assert_equal 'Foo', m.prerequisites

    assert_equal "1. Overview\  2. The main part\  3. Summary", m.syllabus
    m.syllabus = 'Bar'
    assert_equal "Bar", m.syllabus

    assert_equal "- Understand the new materials model\  - Apply the new material model", m.learning_objectives
    m.learning_objectives = 'Learn stuff'
    assert_equal "Learn stuff", m.learning_objectives

    assert_equal ['Software Engineering','MATHEMATICS'], m.fields
    m.fields = ['Software Engineering']
    assert_equal ['Software Engineering'], m.fields

    dump = m.dump
    parsed_json = JSON.parse(m.to_json, symbolize_names: true)
    [:id, :title, :url, :description, :doi,:last_scraped, :scraper_record,
     :remote_created_date,  :remote_updated_date, :collection_ids, :keywords,
     :scientific_topic_names, :scientific_topic_uris, :operation_names, :operation_uris,
     :licence, :difficulty_level, :contributors, :authors, :target_audience, :node_ids, :node_names,
     :external_resources_attributes, :resource_type, :other_types, :version, :status, :date_created, :date_modified,
     :date_published, :subsets, :prerequisites, :syllabus, :learning_objectives, :fields, :event_ids].each do |attr|
      assert_equal m.send(attr), m[attr.to_s], "Unexpected value of '#{attr}' for material when using []"
      assert_equal m.send(attr), dump[attr.to_s], "Unexpected value of '#{attr}' for material in hash dump"
      assert_equal m.send(attr).to_s, parsed_json[attr].to_s, "Unexpected value of '#{attr}' for material in JSON"
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
      refute res.errors
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

    @material_with_existing_content_provider.content_provider = Tess::API::ContentProvider.new(id: 9)
    @material_with_existing_content_provider.content_provider_id = nil
    VCR.use_cassette('check_existing_content_provider') do
      VCR.use_cassette('create_new_material_with_existing_content_provider') do
        res = @material_with_existing_content_provider.create
        assert res['id'].to_i > 0
        assert_equal 9, res.content_provider_id
      end
    end
  end

  test 'stores errors when attempting to create invalid material' do
    VCR.use_cassette('invalid_material_upload') do
      mat = @invalid_material.create
      assert_include mat.errors.keys, 'description'
      assert_include mat.errors.keys, 'url'
    end
  end
end
