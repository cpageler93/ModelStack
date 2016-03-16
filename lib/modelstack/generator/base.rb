module ModelStack
  module Generator
    module Base

      def self.included base
        base.send :include, InstanceMethods
        base.extend ClassMethods
      end

      module InstanceMethods

        attr_accessor :absolute_output_path
        attr_accessor :data_model

        attr_accessor :user_info_block

        def initialize(data_model, options, generator_block)

          # handle global base options
          handle_base_options(options)

          # give ability to handle options
          handle_options(options)

          # call custom block section
          instance_eval(&generator_block)

          # set attributes to default values if not set
          set_default_attributes

          # create output folder
          create_output_folder

          # store data model
          self.data_model = data_model

        end

        ###########################
        ##      DSL METHODS      ##
        ###########################

        def output_to(path)
          self.absolute_output_path = File.join(Dir.pwd, path)
        end

        ##########################
        ##   INSTANCE METHODS   ##
        ##########################

        def handle_base_options(options)
          class_name = self.class.name.split('::').last.downcase
          output_to "generated/#{class_name}" unless self.absolute_output_path
        end

        def set_default_attributes
        end

        def create_output_folder
          `mkdir -p #{self.absolute_output_path}`
        end

        def set_user_info_block(&block)
          self.user_info_block = block
        end

        def update_user_info(options)
          self.user_info_block.call(options)
        end

        ###############################
        ## SUBCLASS OVERRIDE METHODS ##
        ###############################

        # give the ability to override this method
        def handle_options(options)
          raise GeneratorBaseException.new "handle(options) not implemented in modelstack generator class #{self.class.name}"
        end

        # give the ability to override this method
        def generate
          raise GeneratorBaseException.new "generate(&block) not implemented in modelstack generator class #{self.class.name}"
        end

        # give the ability to override this method
        def number_of_steps
          raise GeneratorBaseException.new "number_of_steps not implemented in modelstack generator class #{self.class.name}"
        end
      end


      module ClassMethods

      end

      class GeneratorBaseException < Exception
      end
    end
  end
end