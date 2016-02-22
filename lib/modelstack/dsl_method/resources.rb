module ModelStack
  module DSLMethod
    class Resources

      attr_accessor :controller

      def initialize
        self.controller = ModelStack::DSLClass::Controller.new
      end

      def self.handle_in_scope(scope, identifier, options, block)
        r = Resources.new

        # find controller class in scope
        c_class = scope.controller_with_identifier(identifier)

        if c_class
          # assign found coltroller
          r.controller = c_class
        else
          # create new controller
          r.controller.identifier = identifier
          scope.controllers << r.controller
        end

        # TODO: set model for controller
        r.load_actions_with_options(options)

        if block
          r.instance_eval(&block)
        end
      end

      def self.handle_in_controller(parent_controller, identifier, options, block)
        r = Resources.new

        # find controller class in scope
        c_class = parent_controller.child_controller_with_identifier(identifier)

        if c_class
          # assign found coltroller
          r.controller = c_class
        else
          # create new controller
          r.controller.identifier = identifier
          parent_controller.child_controllers << r.controller
        end

        # TODO: set model for controller
        r.load_actions_with_options(options)

        if block
          r.instance_eval(&block)
        end
      end

      #############################
      ##       DSL METHODS       ##
      #############################

      def action(identifier, options = {})
        a = ModelStack::DSLReader::Action.read_action(identifier, options)
        self.controller.add_action(a)
      end

      def resources(identifier, options = {}, &block)
        # TODO: handle on :member, or :collection
        ModelStack::DSLMethod::Resources.handle_in_controller(self.controller, identifier, options, block);
      end

      def load_actions_with_options(options)
        action(:index, http_method: :get, on: :collection)
        action(:show, http_method: :get, on: :member)
        action(:update, http_method: :patch, on: :member)
        action(:delete, http_method: :delete, on: :member)
      end

    end

  end
end