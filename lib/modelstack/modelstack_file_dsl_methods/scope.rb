module ModelStack
  module ModelStackFileDslMethods
    class Scope

      attr_accessor :generator

      attr_accessor :path

      ############################
      ##     DSL ATTRIBUTES     ##
      ############################

      attr_accessor :controllers

      ############################

      def initialize
        self.controllers = []
      end

      def self.handle(generator, options, block)
        scope = Scope.new
        scope.generator = generator

        scope.path = options[:path]

        scope.instance_eval(&block)
        return scope
      end

      def resources(identifier, options = {}, &block)
        puts "handle resources in scope #{self} #{identifier}, options #{options} block #{block}"
      end

      def controller(identifier, options = {}, &block)
        controller = ModelStackFileDslMethods::Controller.handle(self.generator, identifier, options, block)
        self.controllers << controller
      end

      def scope(options, &block)
        puts "handle scope in scope #{self}"
      end

    end
  end
end