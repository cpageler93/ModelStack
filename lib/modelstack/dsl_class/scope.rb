module ModelStack
  module DSLClass
    class Scope

      attr_accessor :path
      attr_accessor :controllers

      def initialize
        self.controllers = []
      end

      def description_object
        {
          path: self.path,
          controllers: self.controllers.collect{|c| c.description_object }
        }
      end

      def controller_with_identifier(identifier)
        rt = nil

        self.controllers.each do |c|
          if c.identifier == identifier
            rt = c
            break;
          end
        end

        return rt
      end

      def as_json
        {
          path: self.path,
          controllers: self.controllers
        }
      end

    end
  end
end