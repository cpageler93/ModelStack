module ModelStack
  module ModelStackFileDslMethods
    class Resources

      attr_accessor :generator

      attr_accessor :identifier

      ############################
      ##     DSL ATTRIBUTES     ##
      ############################

      attr_accessor :actions
      attr_accessor :resourcess

      ############################

      def initialize
        self.actions = []
        self.resourcess = []
      end

      def self.handle(generator, identifier, options, block)
        resources = Resources.new
        resources.identifier = identifier

        resources.instance_eval(&block)

        return resources
      end

      #############################
      ##       DSL METHODS       ##
      #############################

      def action(action_identifier, options = {})
        puts "handle action #{action_identifier} in resource"
      end

      def resources(identifier, options = {}, &block)
        resources = ModelStackFileDslMethods::Resources.handle(self.generator, identifier, options, block);
        self.resourcess << resources
      end

    end
  end
end