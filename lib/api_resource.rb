module ApiResource

  def create
    response = Uploader.do_upload(self, true, self.class.data_type, "/#{self.class.resource_path}.json", 'post')
    self.id = response['id']

    self
  end

  def update
    Uploader.do_upload(self, true, self.class.data_type, "/#{self.class.resource_path}/#{self.id}.json", 'put')

    self
  end

  def create_or_update
    if exists?
      update
    else
      create
    end

    self
  end

  def exists?
    response = Uploader.do_upload(self, true, self.class.data_type, "/#{self.class.resource_path}/check_exists.json", 'post')
    self.id = response['id']

    !response['id'].nil?
  end

end
