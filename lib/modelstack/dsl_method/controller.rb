module ModelStack
  module DSLMethod
    class Controller

      attr_accessor :controller

      def initialize
        self.controller = ModelStack::DSLClass::Controller.new
      end

      def self.handle_in_scope(scope, identifier, options, block)
        c = Controller.new

        # find controller class in scope
        c_class = scope.controller_with_identifier(identifier)

        if c_class
          # assign found coltroller
          c.controller = c_class
        else
          # create new controller
          c.controller.identifier = identifier
          scope.controllers << c.controller
        end

        if block
          c.instance_eval(&block)
        end
      end

      #############################
      ##       DSL METHODS       ##
      #############################

      def action(identifier, options = {})
        a = ModelStack::DSLReader::Action.read_action(identifier, options)
        self.controller.add_action(a)
      end

    end

  end
end