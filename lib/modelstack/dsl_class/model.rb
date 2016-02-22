module ModelStack
  module DSLClass
    class Model

      attr_accessor :identifier
      attr_accessor :name
      attr_accessor :description
      attr_accessor :attributes
      attr_accessor :primary_key

      def initialize
        self.attributes = []
      end

    end
  end
end