module ModelStack
  module Generator
    module Base

      def self.included base
        base.send :include, InstanceMethods
        base.extend ClassMethods
      end

      module InstanceMethods

        attr_accessor :absolute_output_path

        ###########################
        ##      DSL METHODS      ##
        ###########################

        def output_to(path)
          self.absolute_output_path = File.join(Dir.pwd, path)
        end

        def handle_base_options(options)
          class_name = self.class.name.split('::').last.downcase
          output_to "generated/#{class_name}" unless self.absolute_output_path
        end

        def set_default_attributes
        end

        # give the ability to override this method
        def handle_options(options)
          raise GeneratorBaseException.new "handle(options) not implemented in modelstack generator class #{self.class.name}"
        end

        # give the ability to override this method
        def generate(data_model)
          raise GeneratorBaseException.new "generate(model_data) not implemented in modelstack generator class #{self.class.name}"
        end
      end



      module ClassMethods

        def generate(data_model, options, block)

          # create new generator instance
          gen = self.new

          # handle global base options
          gen.handle_base_options(options)

          # give ability to handle options
          gen.handle_options(options)

          # call custom block section
          gen.instance_eval(&block)

          # set attributes to default values if not set
          gen.set_default_attributes

          # start generation
          gen.generate(data_model)

        end

      end

      class GeneratorBaseException < Exception
      end
    end
  end
end