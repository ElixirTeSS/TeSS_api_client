# TeSS API Client
A gem for uploading data to the [TeSS](http://tess.elixir-uk.org) portal. Use if you have training or event content you wish to push to TeSS.

## Get Started
Add the TeSS API to your Gemfile and use bundle to install

    echo "gem 'tess_api_client', :git => git://github.com/ElixirUK/TeSS_api_client.git" >> Gemfile

    bundle install 

Create a config file containing the TeSS instance info & your TeSS credentials (uses <https://dev.tess.elixir-europe.org> by default):

    cp uploader_config.example.txt uploader_config.txt

    nano uploader_config.txt

...OR configure in your code:

```ruby
Tess::API.config = {
    'host' => 'dev.tess.elixir-europe.org',
    'port' => '443',
    'protocol' => 'https',
    'user_email' => 'test.user@example.com',
    'user_token' => 'MyAPIToken'
}
```

Create a new ruby script which uses the gem. Use the ContentProvider model to create a new content provider in TeSS and the Material or Event model to create new resources.

    $ nano my_upload_script.rb

```ruby
require 'tess_api_client'

content_provider = Tess::API::ContentProvider.new(
    title: 'My Organization Name',
    url: 'https://my.org.org/',
    image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/2000px-Smiley.svg.png',
    description: "We're sharing our content with TeSS!")

material = Tess::API::Material.new(
    title: 'How to use TeSS API',
    url: 'http://mysite.org/tess_api',
    description: 'Everything you need to know to get you started using the TeSS API',
    doi: 'http://dx.doi.org/10002-20fk',
    remote_updated_date: Time.now,
    content_provider: content_provider, # The content provider is created if needed when the material is created.
    scientific_topic: ['Computational Biology'],
    keywords: ['tutorial', 'TeSS', 'sharing'])

material.create_or_update # Creates the material, or updates the existing entry if it already exists
```

## Further Examples
More examples can be found in the `test` directory of this repository, or in the [TeSS Scrapers repository](https://github.com/ElixirTeSS/TeSS_scrapers)
