module ModelStack
  module DSLMethod
    class ModelStackFile

      attr_accessor :generator
      attr_accessor :modelstack_filename

      def initialize(generator, modelstack_filename)
        self.generator = generator
        self.modelstack_filename = modelstack_filename

        read_absolute_file(self.modelstack_filename)
      end

      def get_binding(str)
        return binding
      end

      ###########################
      ##      DSL METHODS      ##
      ###########################

      def read_file(relative_filename)
        modelstack_filename_dir = File.dirname(self.modelstack_filename)
        absolute_filename = File.join(modelstack_filename_dir, relative_filename)

        modelstack_file = ModelStack::ModelStackFile.new(generator: self.generator, modelstack_filename: absolute_filename)
        modelstack_file.read_file_content
      end

      def read_absolute_file(modelstack_filename)
        content = File.read(modelstack_filename)

        # check content
        if content.tr!('“”‘’‛', %(""'''))
          Helper.log.error "Your #{File.basename(modelstack_filename)} has had smart quotes sanitised. " \
                      'To avoid issues in the future, you should not use ' \
                      'TextEdit for editing it. If you are not using TextEdit, ' \
                      'you should turn off smart quotes in your editor of choice.'.red
        end

        exec_parse = Proc.new do
          eval(content, get_binding("binding"), modelstack_filename)
        end

        if $debug
          exec_parse.call
        else
          begin
            exec_parse.call
          rescue NameError => ex
            line = ex.backtrace.first.match(/#{Regexp.escape(modelstack_filename)}:(\d+)/)[1]
            name = ex.name;
            stop_parsing("Error in file #{modelstack_filename} line #{line} at ´#{name}´")
          rescue NoMethodError => ex
            line = ex.backtrace.first.match(/#{Regexp.escape(modelstack_filename)}:(\d+)/)[1]
            name = ex.name
            stop_parsing("Error in file #{modelstack_filename} line #{line} at ´#{name}´")
          end
        end
      end

      def stop_parsing(message)
        raise message
      end

      def name(name)
        self.generator.name = name
      end

      def default_attributes(&block)
        ModelStack::DSLMethod::DefaultAttributes.handle(self.generator, block)
      end

      def default_primary_key(default_primary_key)
        ModelStack::DSLMethod::DefaultPrimaryKey.handle(self.generator, default_primary_key)
      end

      def model(identifier, &block)
        ModelStack::DSLMethod::Model.handle(self.generator, identifier, block)
      end

      def controller(identifier, options = {}, &block)
        ModelStack::DSLMethod::Controller.handle_in_scope(self.generator.default_scope, identifier, options, block)
      end

      def resources(identifier, options = {}, &block)
        ModelStack::DSLMethod::Resources.handle_in_scope(self.generator.default_scope, identifier, options, block)
      end

      def scope(options, &block)
        ModelStack::DSLMethod::Scope.handle_in_scope(self.generator, options, block)
      end

      def generate(generator_name, options = {}, &block)
        self.generator.generators << ModelStack::DSLClass::Generator.new(generator_name, options, block)
      end

    end
  end
end