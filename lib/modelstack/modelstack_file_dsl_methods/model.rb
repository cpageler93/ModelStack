module ModelStack
  module ModelStackFileDslMethods
    class Model

      attr_accessor :generator
      attr_accessor :identifier

      ############################
      ##     DSL ATTRIBUTES     ##
      ############################

      attr_accessor :name
      attr_accessor :description
      attr_accessor :attributes
      attr_accessor :primary_key


      ############################

      def self.handle(generator, identifier, block)
        model = Model.new
        model.generator = generator
        model.identifier = identifier

        model.instance_eval(&block)
        return model
      end

      #############################
      ##       DSL METHODS       ##
      #############################

      def name(name)
        self.name = name
      end

      def description(description)
        self.description = description
      end

      def default_attributes
        self.generator.default_attributes.each do |default_attribute|
          add_attribute(default_attribute)
        end
      end

      def default_primary_key
        self.primary_key = self.generator.default_primary_key
      end

      def attribute(identifier, options)
        a = AttributeReader.read_attribute(identifier, options)
        add_attribute(a)
      end

      ############################

      def get_identifier
        return @identifier
      end

      def get_name
        return @name
      end

      def get_description
        return @description
      end

      private

      def add_attribute(attribute)
        self.attributes ||= []
        self.attributes << attribute
      end

    end
  end
end