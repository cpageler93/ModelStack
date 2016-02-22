module ModelStack
  module DSLReader
    class Attribute

      def self.read_attribute(identifier, options)
        ma = ModelStack::DSLClass::Attribute.new

        ma.identifier = identifier
        ma.type = options[:type]
        ma.nullable = options[:nullable]

        return ma
      end

    end
  end
end