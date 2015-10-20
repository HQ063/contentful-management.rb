require_relative 'resource'

module Contentful
  module Management
    # A ContentType's validations schema
    class Validation
      include Contentful::Management::Resource

      property :in, :array
      property :size, :hash
      property :present, :boolean
      property :regexp, :hash
      property :linkContentType, :array
      property :range, :hash
      property :linkMimetypeGroup, :string
      property :linkField, :boolean

      def properties_to_hash
        properties.each_with_object({}) do |(key, value), results|
          results[key] = value if Field.value_exists?(value)
        end
      end

      # Returns type of validation
      def type
        properties.keys.reject { |key| key == :validations }.each do |type|
          value = self.send(Support.snakify(type))
          return type if !value.nil? && value
        end
      end

    end
  end
end
