class Resource

  def initialize(params = {})
    @params = params.with_indifferent_access

    @params.each do |attr, value|
      self.send("#{attr}=", value)
    end
  end

  def dump
    @params
  end

  def to_json
    self.dump.to_json
  end

  def [](var)
    @params[var]
  end

end
