module ModelStack
  module DSLMethod
    class Scope

      attr_accessor :generator
      attr_accessor :scope

      def initialize
        self.scope = ModelStack::DSLClass::Scope.new
      end

      def self.handle_in_scope(generator, options, block)
        s = Scope.new
        s.generator = generator

        s.scope.path = options[:path]

        generator.scopes << s.scope

        s.instance_eval(&block)
      end

      #############################
      ##       DSL METHODS       ##
      #############################

      def resources(identifier, options = {}, &block)
        ModelStack::DSLMethod::Resources.handle_in_scope(self.scope, identifier, options, block)
      end

      def controller(identifier, options = {}, &block)
        ModelStack::DSLMethod::Controller.handle_in_scope(self.scope, identifier, options, block)
      end

    end
  end
end