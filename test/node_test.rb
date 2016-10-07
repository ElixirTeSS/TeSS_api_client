require 'test_helper'

class NodeTest < Test::Unit::TestCase

  setup do
    @node = Node.new(
        { name: 'Neverland',
          member_status: Node::MEMBER_STATUS[:MEMBER]
        })

    @node_full = Node.new(
        { id: 1,
          name: 'Narnia',
          url: 'http://elixir.narnia',
          image_url: 'http://elixir.narnia/images/logo.png',
          description: 'A magical place',
          member_status: Node::MEMBER_STATUS[:MEMBER]
        })
  end

  test 'can initialize a node' do
    assert_nothing_raised do
      Node.new(
          { name: 'Neverland',
            member_status: Node::MEMBER_STATUS[:MEMBER]
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

    assert_equal n.member_status, Node::MEMBER_STATUS[:MEMBER]
    n.member_status = Node::MEMBER_STATUS[:OBSERVER]
    assert_equal n.member_status, Node::MEMBER_STATUS[:OBSERVER]

    dump = n.dump
    parsed_json = JSON.parse(n.to_json)

    [:name, :url, :image_url, :description, :member_status, :id].each do |attr|
      assert_equal n.send(attr), n[attr.to_s], "Unexpected value of '#{attr}' for node when using []"
      assert_equal n.send(attr), dump[attr.to_s], "Unexpected value of '#{attr}' for node in hash dump"
      assert_equal n.send(attr).to_s, parsed_json[attr.to_s].to_s, "Unexpected value of '#{attr}' for node in JSON"
    end
  end

  test 'can dump node as hash' do
    hash = @node.dump

    assert_equal Node::MEMBER_STATUS[:MEMBER], hash['member_status']
    assert_equal 'Neverland', hash['name']
  end


  test 'can dump node as JSON' do
    json = @node.to_json
    parsed = nil

    assert_nothing_raised do
      parsed = JSON.parse(json)
    end

    assert_equal Node::MEMBER_STATUS[:MEMBER], parsed['member_status']
    assert_equal 'Neverland', parsed['name']
  end

end
