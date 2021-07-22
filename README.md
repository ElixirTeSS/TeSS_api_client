# PaN Training Catalogue API Client
A gem for uploading data to the [PaN catalogue](https://pan-training.hzdr.de) portal. Use if you have training or event content you wish to push to the PaN training catalogue.

## Get Started
Add the catalogue API to your Gemfile and use bundle to install

`$ echo "gem 'tess_api_client', :git => https://github.com/pan-training/training-catalogue-api-client" >> Gemfile`

`$ bundle install` 

Create a new ruby script which uses the gem. Use the ContentProvider model to create a new content provider in our catalogue and the Material or Event model to create new resources. 
`$ nano my_upload_script.rb`

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
    short_description: 'Everything you need to know to get you started using the TeSS API',
    doi: 'http://dx.doi.org/10002-20fk',
    remote_updated_date: Time.now,
    content_provider: content_provider, # The content provider is created if needed when the material is created.
    scientific_topic: ['Computational Biology'],
    keywords: ['tutorial', 'TeSS', 'sharing'])

material.create
```
