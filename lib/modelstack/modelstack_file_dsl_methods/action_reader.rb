module ModelStack
  module ModelStackFileDslMethods
    class ActionReader

      def self.read_action(identifier, options)
        ma = ModelStack::ModelStackAction.new
        ma.identifier = identifier
        ma.http_method = options[:http_method]
        ma.on = options[:on]
        return ma
      end

    end
  end
end