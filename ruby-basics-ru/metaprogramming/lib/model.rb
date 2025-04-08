# frozen_string_literal: true

# BEGIN
module Model
  def self.included(base)
    base.extend(ModelClassMethods)
    base.send :prepend, ModelPrependMethods
  end

  def attributes
    hash = {}
    temp_array = methods.select! { |element| element.to_s.end_with?('default') }
    temp_array.each do |var|
      hash[var[0...-8].to_sym] = send("#{var[0...-8]}")
    end
    hash
  end

  module ModelClassMethods
    def attribute(name, options = {})
      define_method name do
        unless instance_variables.include?(:"@#{name}")
          send("#{name}_default")
        end
        instance_variable_get "@#{name}"
      end

      define_method "#{name}_default" do
        instance_variable_set "@#{name}", options[:default]
      end

      define_method "#{name}=" do |value|
        if value.nil?
          instance_variable_set "@#{name}", nil
        else
          case options[:type]
          when :boolean then instance_variable_set "@#{name}", value ? true : false
          when :integer then instance_variable_set "@#{name}", value.to_i
          when :string then instance_variable_set "@#{name}", value.to_s
          when :datetime then instance_variable_set "@#{name}", DateTime.parse(value)
          when nil then instance_variable_set "@#{name}", value
          end
        end
      end
    end
  end

  module ModelPrependMethods
    def initialize(attributes = {})
      attributes.each do |attribute|
        send("#{attribute[0]}=", attribute[1])
      end
    end
  end
end
# END
