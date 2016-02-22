module ModelStack
  module DSLMethod
    class DefaultPrimaryKey

      attr_accessor :generator

      def self.handle(generator, default_primary_key)
        dpk = default_primary_key.is_a?(Array) ? default_primary_key : [default_primary_key]
        generator.default_primary_key = dpk
      end

    end
  end
end