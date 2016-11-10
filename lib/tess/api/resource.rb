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

      # Metaprogramming!
      def self.cv_attributes(hash)
        hash.each do |attr, vocab|
          alias_method "old_#{attr}=", "#{attr}="

          define_method("#{attr}=") do |value|
            is_array = value.is_a?(Array)
            value = [value] unless is_array

            actual_value = value.map do |v|
              if v.is_a?(Symbol)
                vocab[v]
              else
                v
              end
            end

            actual_value = actual_value[0] unless is_array

            send("old_#{attr}=", actual_value)
          end
        end
      end

    end
  end
end
