require 'json'
require 'logger'

module ModelStack
  module Generator
    class Collector

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
        raise CollectorException.new "ModelStack file ´#{File.basename(modelstack_filename)}´ added twice" if self.modelstack_files.include?(modelstack_filename)
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

        # define data model
        data_model = {
          name: self.name,
          models: self.models,
          scopes: self.scopes,
          default_scope: self.default_scope
        }

        # constantize all generators
        generator_instances = []
        self.generators.each do |generator|
          generator_instance = create_generator_instance(generator, data_model)
          generator_instances << generator_instance
        end

        number_of_total_steps = 0
        number_of_total_steps_done = 0

        # get number of total steps
        generator_instances.each do |generator_instance|
          number_of_total_steps += generator_instance.number_of_steps
        end

        # return if no steps found
        if number_of_total_steps == 0
          raise CollectorException.new "Not a single generator specified in modelstack file"
        end

        # setup and start progress bar
        p = ProgressBar.create(
          :format => '%t: %B %p%% %a %E',
          :total => number_of_total_steps,
          :autofinish => false
        )

        p.log "start generation"

        # enumerate all generators with index
        self.generators.each_with_index do |generator, generator_index|

          # get generator classes
          dsl_class_generator = self.generators[generator_index]
          generator_instance = generator_instances[generator_index]

          # set up some variables
          generator_name = dsl_class_generator.name
          current_number_of_steps = generator_instance.number_of_steps
          current_number_of_steps_done = 0
          current_total_done = 0
          default_message = "generate #{generator_name}"

          # prepare generator callbacks
          generator_instance.set_update_to_step_block do |step|
            current_number_of_steps_done = step
            current_total_done = number_of_total_steps_done + current_number_of_steps_done

            p.progress = current_total_done
          end

          generator_instance.set_update_title_block do |title|
            p.title = "#{default_message}: #{title}"
          end

          generator_instance.set_log_message_block do |log|
            p.log "#{default_message}: #{log}"
          end

          # show generation start
          p.title = default_message
          p.log default_message

          # start generation
          generator_instance.generate

          p.log "#{default_message}: done"

          # update total number
          number_of_total_steps_done += current_number_of_steps
        end

        p.format = '%t: %B %p%% %a'
        p.title = "generation done"

        p.finish
      end

      def create_generator_instance(dsl_class_generator, data_model)
        # generate class name
        class_name = dsl_class_generator.name.capitalize
        class_in_namespace = "ModelStack::Generator::#{class_name}"

        # try to constantize
        clazz = nil
        begin
          clazz = class_in_namespace.constantize
        rescue Exception => ex
          raise CollectorException.new "Generator class with name ´#{class_name}´ was not found"
        end

        generator_instance = clazz.new(data_model, dsl_class_generator.options, dsl_class_generator.block)

        return generator_instance
      end

    end
  end

  class CollectorException < Exception
  end
end