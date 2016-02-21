module ModelStack
  module ModelStackFileDslMethods
    class AttributeReader

      def self.read_attribute(identifier, options)
        ma = ModelStack::ModelStackAttribute.new
        ma.identifier = identifier
        ma.type = options[:type]
        ma.nullable = options[:nullable]
        return ma
      end

    end
  end
end