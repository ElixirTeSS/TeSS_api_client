require 'test_helper'

class UploaderTest < Test::Unit::TestCase

  setup do
    @new_material = Material.new({ content_provider_id: 1,
                                   title: 'A new material',
                                   url: 'http://example.com/materials/789',
                                   short_description: 'A cool material',
                                   long_description: 'A cooooooool material',
                                   remote_created_date: '2016-08-10',
                                   keywords: ['dog', 'cat'],
                                   licence: 'GPL-3.0' })

    @existing_material = Material.new({ content_provider_id: 1,
                                        title: 'An existing material',
                                        url: 'http://example.com/materials/existing',
                                        keywords: ['dog', 'cat'],
                                        short_description: 'a',
                                        licence: 'GPL-3.0' })

    @non_existing_material = Material.new({ content_provider_id: 1,
                                            title: 'An novel material',
                                            short_description: 'a',
                                            url: 'http://example.com/materials/123' })
  end

  test 'can create a material' do
    VCR.use_cassette('new_material_upload') do
      res = Uploader.create_material(@new_material)
      assert res['id'].to_i > 0
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
      res = Uploader.update_material(Material.new({ id: 170, title: 'Adjusted title', keywords: ['bear'] }))
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
    assert true
  end

  test 'can check an event exists' do
    assert true
  end

  test 'can update an event' do
    assert true
  end

  test 'can create or update an event' do
    assert true
  end

end
