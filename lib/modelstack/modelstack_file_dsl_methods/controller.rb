module ModelStack
  module ModelStackFileDslMethods
    class Controller

      attr_accessor :generator
      attr_accessor :identifier

      attr_accessor :model
      attr_accessor :actions

      ############################
      ##     DSL ATTRIBUTES     ##
      ############################


      ############################

      def initialize
        self.actions = []
      end

      def self.handle(generator, identifier, options, block)
        controller = Controller.new
        controller.generator = generator
        controller.identifier = identifier
        controller.actions = []

        controller.model = options[:model]

        controller.instance_eval(&block)
        return controller
      end

      def action(action_identifier, options = {})
        action = ActionReader.read_action(action_identifier, options)
        self.actions << action
      end

    end
  end
end