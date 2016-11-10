require 'test_helper'

class NodeTest < Test::Unit::TestCase

  setup do
    @node = Tess::API::Node.new(
        { name: 'Neverland',
          member_status: Tess::API::Node::MEMBER_STATUS[:member]
        })

    @node_full = Tess::API::Node.new(
        { id: 1,
          name: 'Narnia',
          url: 'http://elixir.narnia',
          image_url: 'http://elixir.narnia/images/logo.png',
          description: 'A magical place',
          member_status: Tess::API::Node::MEMBER_STATUS[:member]
        })
  end

  test 'can initialize a node' do
    assert_nothing_raised do
      Tess::API::Node.new(
          { name: 'Neverland',
            member_status: Tess::API::Node::MEMBER_STATUS[:member]
          })
    end
  end

  test 'can get/set all attributes' do
    n = @node_full

    assert_equal n.id, 1
    n.id = 2
    assert_equal n.id, 2

    assert_equal n.name, 'Narnia'
    n.name = 'Arendelle'
    assert_equal n.name,  'Arendelle'

    assert_equal n.url, 'http://elixir.narnia'
    n.url = 'http://elixir.ar'
    assert_equal n.url, 'http://elixir.ar'

    assert_equal n.image_url, 'http://elixir.narnia/images/logo.png'
    n.image_url = 'http://elixir.ar/images/logo.png'
    assert_equal n.image_url, 'http://elixir.ar/images/logo.png'

    assert_equal n.description, 'A magical place'
    n.description = 'Cold'
    assert_equal n.description, 'Cold'

    assert_equal n.member_status, Tess::API::Node::MEMBER_STATUS[:member]
    n.member_status = Tess::API::Node::MEMBER_STATUS[:observer]
    assert_equal n.member_status, Tess::API::Node::MEMBER_STATUS[:observer]

    dump = n.dump
    parsed_json = JSON.parse(n.to_json)

    [:name, :url, :image_url, :description, :member_status, :id].each do |attr|
      assert_equal n.send(attr), n[attr.to_s], "Unexpected value of '#{attr}' for node when using []"
      assert_equal n.send(attr), dump[attr.to_s], "Unexpected value of '#{attr}' for node in hash dump"
      assert_equal n.send(attr).to_s, parsed_json[attr.to_s].to_s, "Unexpected value of '#{attr}' for node in JSON"
    end
  end

  test 'can set CV-using fields with symbols or literals' do
    e = Tess::API::Node.new({ member_status: :member })

    assert_equal Tess::API::Node::MEMBER_STATUS[:member], e.member_status

    e = Tess::API::Node.new({ member_status: Tess::API::Node::MEMBER_STATUS[:observer] })

    assert_equal Tess::API::Node::MEMBER_STATUS[:observer], e.member_status
  end

  test 'can dump node as hash' do
    hash = @node.dump

    assert_equal Tess::API::Node::MEMBER_STATUS[:member], hash['member_status']
    assert_equal 'Neverland', hash['name']
  end

  test 'can dump node as JSON' do
    json = @node.to_json
    parsed = nil

    assert_nothing_raised do
      parsed = JSON.parse(json)
    end

    assert_equal Tess::API::Node::MEMBER_STATUS[:member], parsed['member_status']
    assert_equal 'Neverland', parsed['name']
  end

end
