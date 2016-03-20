module ModelStack
  module DSLClass
    class Attribute

      attr_accessor :identifier
      attr_accessor :type
      attr_accessor :nullable

      def as_json
        {
          identifier: self.identifier,
          type: self.type,
          nullable: self.nullable
        }
      end

    end
  end
end