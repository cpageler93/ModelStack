module ModelStack
  module DSLMethod
    class DefaultAttributes

      attr_accessor :generator

      def self.handle(generator, block)
        da = DefaultAttributes.new
        da.generator = generator
        da.instance_eval(&block)
      end

      def attribute(identifier, options)
        a = ModelStack::DSLReader::Attribute.read_attribute(identifier, options)
        self.generator.default_attributes << a
      end

    end
  end
end