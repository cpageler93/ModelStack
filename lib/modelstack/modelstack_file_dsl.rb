module ModelStack
  class ModelStackFileDsl

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

      modelstack_file = ModelStackFile.new(generator: self.generator, modelstack_filename: absolute_filename)
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
      ModelStackFileDslMethods::DefaultAttributes.handle(self.generator, block)
    end

    def default_primary_key(default_primary_key)
      ModelStackFileDslMethods::DefaultPrimaryKey.handle(self.generator, default_primary_key)
    end

    def model(model_identifier, &block)
      model = ModelStackFileDslMethods::Model.handle(self.generator, model_identifier, block)
      self.generator.models << model
    end

    def controller(identifier, options = {}, &block)
      controller = ModelStackFileDslMethods::Controller.handle(self.generator, identifier, options, block)
      self.generator.default_scope.controllers << controller
    end

    def resources(identifier, options = {}, &block)
      puts "handle resources #{identifier}, options #{options} block #{block}"
    end

    def scope(options, &block)
      scope = ModelStackFileDslMethods::Scope.handle(self.generator, options, block)
      self.generator.scopes << scope
    end

  end
end