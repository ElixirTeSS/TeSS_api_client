class Uploader

  def self.check_material(material)
    action = '/materials/check_exists.json'
    data_type = 'material'
    auth = false

    self.do_upload(material,auth,data_type,action,'post')
  end

  def self.create_material(material)
    action = '/materials.json'
    data_type = 'material'
    auth = true

    self.do_upload(material,auth,data_type,action,'post')
  end

  def self.update_material(material)
    action = "/materials/#{material['id']}.json"
    data_type = 'material'
    auth = true

    self.do_upload(material,auth,data_type,action,'put')
  end

  def self.create_or_update_material(material)
    check = Uploader.check_material(material)
    if check.empty?
      result = Uploader.create_material(material)
      puts "Created new material '#{material.title}'"
    else
      material.id = check['id']
      result = Uploader.update_material(material)
      puts "Updated existing material '#{material.title}'"
    end

    result
  end

  def self.check_event(event)
    action = '/events/check_exists.json'
    data_type = 'event'
    auth = false

    self.do_upload(event,auth,data_type,action,'post')
  end

  def self.create_event(event)
    action = '/events.json'
    data_type = 'event'
    auth = true

    self.do_upload(event,auth,data_type,action,'post')
  end

  def self.update_event(event)
    action = "/events/#{event['id']}.json"
    data_type = 'event'
    auth = true

    self.do_upload(event,auth,data_type,action,'put')
  end

  def self.create_or_update_event(event)
    check = Uploader.check_event(event)
    if check.empty?
      result = Uploader.create_event(event)
      puts "Created new event '#{event.title}'"
    else
      event.id = check['id']
      result = Uploader.update_event(event)
      puts "Updated existing event '#{event.title}'"
    end

    result
  end


  def self.check_content_provider(data)
    action = '/content_providers/check_exists.json'
    data_type = 'content_provider'
    auth = false

    self.do_upload(data,auth,data_type,action,'post')
  end

  def self.create_content_provider(data)
    action = '/content_providers.json'
    data_type = 'content_provider'
    auth = true

    self.do_upload(data,auth,data_type,action,'post')
  end

  def self.update_content_provider(data)
    puts "Updating Content Provider #{data.id} - #{data.title}"
    action = "/content_providers/#{data['id']}.json"
    data_type = 'content_provider'
    auth = true

    self.do_upload(data,auth,data_type,action,'put')
  end

  def self.create_or_update_content_provider(content_provider)
    tess_cp = Uploader.check_content_provider(content_provider)
    if (tess_cp and !tess_cp.empty?)
      content_provider.id = tess_cp['id']
      Uploader.update_content_provider(content_provider)
    else
      Uploader.create_content_provider(content_provider)
    end
  end

  def self.do_upload(data, auth, data_type, action, method)
    conf = ScraperConfig.get_config
    url = conf['protocol'] + '://' + conf['host'] + ':' + conf['port'].to_s + action
    # process data to json for uploading

    user_email = conf['user_email']
    user_token = conf['user_token']
    if user_email.nil? or user_token.nil?
      puts 'API connection information missing!'
      return
    end

    # The data to post must be converted to JSON and
    # the proper auth details added.
    if auth
      payload = {:user_email => user_email,
                 :user_token => user_token,
                 data_type.to_sym => data.dump
      }.to_json
    else
      payload = data.to_json
    end

    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    if url =~ /https/
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    if method == 'put'
      req = Net::HTTP::Put.new(uri.request_uri, initheader = { 'Content-Type' =>'application/json' })
    elsif method == 'post'
      req = Net::HTTP::Post.new(uri.request_uri, initheader = { 'Content-Type' =>'application/json' })
    else
      puts "Unknown method '#{method}'!"
      return
    end


    req.body = payload
    res = http.request(req)

    unless res.code == '201' or res.code == '200'
      puts "Upload failed: #{res.code}"
      puts "ERROR: #{res.body}"
      puts "PAYLOAD: #{payload}"
      return {}
    end

    # package_create returns the created package as its result.
    created_record = JSON.parse(res.body) rescue {}
    return created_record
  end

end
