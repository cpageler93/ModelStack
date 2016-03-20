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

      def as_json
        {
          identifier: self.identifier,
          name: self.name,
          description: self.description,
          attributes: self.attributes,
          primary_key: self.primary_key
        }
      end

    end
  end
end