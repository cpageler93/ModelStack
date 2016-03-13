module ModelStack
  module DSLClass
    class Generator

      attr_accessor :name
      attr_accessor :options
      attr_accessor :block

      def initialize(generator_name, options, block)
        self.name = generator_name
        self.options = options
        self.block = block
      end

    end
  end
end