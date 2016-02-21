module ModelStack
  module ModelStackFileDslMethods
    class DefaultAttributes

      attr_accessor :generator

      def self.handle(generator, block)
        da = DefaultAttributes.new
        da.generator = generator
        da.instance_eval(&block)
      end

      def attribute(identifier, options)
        self.generator.default_attributes ||= []
        self.generator.default_attributes << AttributeReader.read_attribute(identifier, options)
      end

    end
  end
end