class Uploader

  # The following methods are just to maintain backwards compatibility
  def self.check_material(material)
    warn '[DEPRECATION] Uploader.check_material is deprecated, please use Material#exists? instead'
    material.exists?
  end

  def self.create_material(material)
    warn '[DEPRECATION] Uploader.create_material is deprecated, please use Material#create instead'
    material.create
  end

  def self.update_material(material)
    warn '[DEPRECATION] Uploader.update_material is deprecated, please use Material#update instead'
    material.update
  end

  def self.create_or_update_material(material)
    warn '[DEPRECATION] Uploader.create_or_update_material is deprecated, please use Material#create_or_update instead'
    material.create_or_update
  end

  def self.check_event(event)
    warn '[DEPRECATION] Uploader.check_event is deprecated, please use Event#exists? instead'
    event.exists?
  end

  def self.create_event(event)
    warn '[DEPRECATION] Uploader.create_event is deprecated, please use Event#create instead'
    event.create
  end

  def self.update_event(event)
    warn '[DEPRECATION] Uploader.update_event is deprecated, please use Event#update instead'
    event.update
  end

  def self.create_or_update_event(event)
    warn '[DEPRECATION] Uploader.create_or_update_event is deprecated, please use Event#create_or_update instead'
    event.create_or_update
  end

  def self.check_content_provider(content_provider)
    warn '[DEPRECATION] Uploader.check_content_provider is deprecated, please use ContentProvider#exists? instead'
    content_provider.exists?
  end

  def self.create_content_provider(content_provider)
    warn '[DEPRECATION] Uploader.create_content_provider is deprecated, please use ContentProvider#create instead'
    content_provider.create
  end

  def self.update_content_provider(content_provider)
    warn '[DEPRECATION] Uploader.update_content_provider is deprecated, please use ContentProvider#update instead'
    content_provider.update
  end

  def self.create_or_update_content_provider(content_provider)
    warn '[DEPRECATION] Uploader.create_or_update_content_provider is deprecated, please use ContentProvider#create_or_update instead'
    content_provider.create_or_update
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
