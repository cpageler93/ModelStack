module ModelStack
  module DSLReader
    class Action

      def self.read_action(identifier, options)
        ma = ModelStack::DSLClass::Action.new

        ma.identifier = identifier
        ma.http_method = options[:http_method]
        ma.on = options[:on]

        ma.set_defaults

        return ma
      end

    end
  end
end