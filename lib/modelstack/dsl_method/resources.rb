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
        unless c_class = scope.controller_with_identifier(identifier)
          # add new controller to scope if not found
          scope.controllers << r.controller
        end

        handle_private(c_class, r, identifier, options, block)
      end

      def self.handle_in_controller(parent_controller, identifier, options, block)
        r = Resources.new

        # find controller class in parent controller
        unless c_class = parent_controller.child_controller_with_identifier(identifier)
          # add new controller to parent controller if not found
          parent_controller.child_controllers << r.controller
        end

        handle_private(c_class, r, identifier, options, block)
      end

      def self.handle_private(c_class, r, identifier, options, block)

        # check if controller was found
        if c_class
          # assign found controller
          r.controller = c_class
        else
          r.controller.identifier = identifier
          r.controller.model = identifier.to_s.singularize
        end

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
        ModelStack::DSLMethod::Resources.handle_in_controller(self.controller, identifier, options, block);
      end

      def load_actions_with_options(options)

        actions = [
          {
            identifier: :index,
            http_method: :get,
            on: :collection
          },
          {
            identifier: :show,
            http_method: :get,
            on: :member
          },
          {
            identifier: :update,
            http_method: :patch,
            on: :member
          },
          {
            identifier: :delete,
            http_method: :delete,
            on: :member
          }
        ]

        # get `only` options
        if only = options[:only]
          only = [only] unless only.is_a?(Array)
        end

        # get `except` options
        if except = options[:except]
          except = [except] unless except.is_a?(Array)
        end

        # filter ´only´ and ´except´ options
        actions.select!{|a| only.include?(a[:identifier]) } if only
        actions.select!{|a| !except.include?(a[:identifier]) } if except

        actions.each do |a|
          action(a[:identifier], http_method: a[:http_method], on: a[:on])
        end

      end

    end

  end
end