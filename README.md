# TeSS_api_client
A gem for uploading data to the [TeSS](http://tess.elixir-uk.org) portal. Use if you have training or event content you wish to push to TeSS.

## Get Started
Add the TeSS API to your Gemfile and use bundle to install

`$ echo "gem 'tess_api_client', :git => git://github.com/ElixirUK/TeSS_api_client.git" >> Gemfile`

`$ bundle install` 

Create a new ruby script which uses the gem. Use the ContentProvider model to create a new content provider in TeSS and the Material or Event model to create new resources. 
`$ nano my_upload_script.rb`

```ruby
require 'tess_api_client'
content_provider = ContentProvider.new(
    "My Organization Name",
    "https://my.org.org/",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/2000px-Smiley.svg.png",
    "We're sharing our content with TeSS!"
    )
    
content_provider.create_or_update

material = Material.new(title: 'How to use TeSS API',
                        url: 'http://mysite.org/tess_api',
                        short_description: "Everything you need to know to get you started using the TeSS API",
                        doi: 'http://dx.doi.org/10002-20fk',
                        remote_updated_date: Time.now,
                        remote_created_date: nil,
                        content_provider_id: content_provider['id'],
                        scientific_topic: ['Computational Biology'],
                        keywords: ['tutorial', 'TeSS', 'sharing'])
                          
material.create
```

If a website has schema.org content embedded in either RDFa or Microdata formats you can extract it easily. First convert it to RDF, and then use the RdfaExtractor library to parse it.


### RDFa 
```ruby
rdf_page = RDF::Graph.load('http://url.of.my.resource.org/rdf_page', format: :rdfa)
material = RdfaExtractor.parse_rdfa(rdf_page, 'CreativeWork') 
```

### Microdata
```ruby
rdf_page = RDF::Graph.load('http://url.of.my.resource.org/md_page', format: :microdata)
event = RdfaExtractor.parse_rdfa(rdf_page, 'Event') 
```

Note you must pass the schema.org type to extract it e.g. 'CreativeWork' extracts http://schema.org/CreativeWork

                          
## Futher Examples
Lots more examples can be found in the TeSS Scrapers repository https://github.com/ElixirUK/TeSS_scrapers
