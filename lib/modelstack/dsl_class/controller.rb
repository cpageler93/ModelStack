module ModelStack
  module DSLClass
    class Controller

      attr_accessor :identifier
      attr_accessor :model
      attr_accessor :actions
      attr_accessor :child_controllers

      def initialize
        self.actions = []
        self.child_controllers = []
      end

      def child_controller_with_identifier(identifier)
        rt = nil

        self.child_controllers.each do |c|
          if c.identifier == identifier
            rt = c
            break;
          end
        end

        return rt
      end

      def add_action(action)
        duplicated = (self.actions.select do |a|
          a.identifier  == action.identifier &&
          a.http_method == action.http_method &&
          a.on          == action.on
        end).length > 0

        raise "Duplicated action ´#{action.identifier}´ in controller ´#{self.identifier}´" if duplicated

        self.actions << action

      end

      def as_json
        {
          identifier: self.identifier,
          model: self.model,
          actions: self.actions.collect{|a|a.as_json},
          child_controllers: self.child_controllers.collect{|cc|cc.as_json}
        }
      end

    end
  end
end