module ModelStack
  module DSLClass
    class Action

      attr_accessor :identifier
      attr_accessor :http_method
      attr_accessor :on


      def set_defaults
        self.http_method  ||= :get
        self.on           ||= :member
      end

      def description_object
        {
          identifier: self.identifier,
          http_method: self.http_method,
          on: self.on
        }
      end

      def as_json
        {
          identifier: self.identifier,
          http_method: self.http_method,
          on: self.on
        }
      end

    end
  end
end