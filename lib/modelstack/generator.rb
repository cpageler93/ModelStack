require 'json'

module ModelStack
  module Generator
    class Base

      attr_accessor :modelstack_files
      attr_accessor :generators

      attr_accessor :default_attributes
      attr_accessor :default_primary_key

      attr_accessor :name
      attr_accessor :models
      attr_accessor :default_scope
      attr_accessor :scopes

      def initialize
        self.modelstack_files = []
        self.generators = []

        self.default_scope = ModelStack::DSLClass::Scope.new
        self.default_scope.path = "/"

        self.default_attributes = []

        self.models = []
        self.scopes = [self.default_scope]
      end

      def add_modelstack_file(modelstack_filename)
        raise GeneratorException.new "ModelStack file #{File.basename(modelstack_filename)} added twice" if self.modelstack_files.include?(modelstack_filename)
        self.modelstack_files << modelstack_filename
      end

      def perform_generation
        validate
        generate
      end

      private

      def validate
        # check model attributes
        # check models in controllers
        # check generator names
      end

      def generate
        # obj = {
        #   name: self.name,
        #   scopes: self.scopes.collect{|s| s.description_object},
        #   default_attributes: self.default_attributes.collect{|m|{
        #     identifier: m.identifier,
        #     type: m.type,
        #     nullable: m.nullable
        #   }},
        #   default_primary_key: self.default_primary_key,
        #   models: self.models.collect{|m|{
        #     identifier: m.identifier,
        #     name: m.name,
        #     description: m.description,
        #     attributes: m.attributes.collect{|a|{
        #       identifier: a.identifier,
        #       type: a.type,
        #       nullable: a.nullable
        #     }},
        #     primary_key: m.primary_key
        #   }}
        # }
        # puts "generate #{JSON.pretty_generate(obj)}"

        self.generators.each do |generator|
          class_name = "ModelStack::Generator::#{generator.name}"
          clazz = class_name.constantize

          generator_instance = clazz.generate({
            name: self.name,
            models: self.models,
            scopes: self.scopes,
            default_scope: self.default_scope
          })
        end
      end

    end
  end

  class GeneratorException < Exception
  end
end