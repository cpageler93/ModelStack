module ModelStack
  module DSLMethod
    class Model

      attr_accessor :generator
      attr_accessor :model

      def initialize
        self.model = ModelStack::DSLClass::Model.new
      end

      def self.handle(generator, identifier, block)
        m = Model.new
        m.generator = generator
        m.model.identifier = identifier

        m.instance_eval(&block)

        m.generator.models << m.model
      end

      #############################
      ##       DSL METHODS       ##
      #############################

      def name(name)
        self.model.name = name
      end

      def description(description)
        self.model.description = description
      end

      def default_attributes
        self.generator.default_attributes.each do |default_attribute|
          add_attribute(default_attribute)
        end
      end

      def default_primary_key
        self.model.primary_key = self.generator.default_primary_key
      end

      def attribute(identifier, options)
        a = ModelStack::DSLReader::Attribute.read_attribute(identifier, options)
        add_attribute(a)
      end

      private

      def add_attribute(attribute)
        self.model.attributes << attribute
      end

    end
  end
end