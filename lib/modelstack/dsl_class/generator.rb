module ModelStack
  module DSLClass
    class Generator

      attr_accessor :name
      attr_accessor :options

      def initialize(generator_name, options)
        self.name = generator_name
        self.options = options
      end

    end
  end
end