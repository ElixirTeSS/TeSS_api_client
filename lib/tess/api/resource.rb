module Tess
  module API
    class Resource

      def initialize(params = {})
        params.each do |attr, value|
          self.send("#{attr}=", value)
        end
      end

      def dump
        hash = {}

        self.instance_variables.each do |var|
          varname = var.to_s.gsub(/@/,'')
          hash[varname] = self.instance_variable_get(var)
        end

        hash
      end

      def to_json
        self.dump.to_json
      end

      def [](var)
        self.instance_variable_get('@' + var)
      end

    end
  end
end
