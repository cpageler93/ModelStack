module ModelStack
  class ModelStackFile

    attr_accessor :generator
    attr_accessor :modelstack_filename

    def self.generate(options = {})

      # remove keys with nil values
      options.delete_if { |k, v| v.nil? }

      # apply option defaults
      options = {
        :generator => ModelStack::Generator::Collector.new,
        :modelstack_filename => absolute_modelstack_filename(Dir.getwd, nil)
      }.merge(options)

      modelstack_file = ModelStackFile.new(options)
      modelstack_file.read_file_content

      modelstack_file.generate

      return modelstack_file
    end

    def self.absolute_modelstack_filename(base_dir, relative_name = nil)
      return File.join(base_dir, relative_name) if relative_name

      filename ||= File.join(base_dir, 'main.modelstack') if File.exist?(File.join(base_dir, 'main.modelstack'))
      filename ||= File.join(base_dir, 'model.modelstack') if File.exist?(File.join(base_dir, 'model.modelstack'))

      return filename
    end

    def initialize(options)
      self.generator = options[:generator]
      self.modelstack_filename = options[:modelstack_filename]

      raise ModelStackFileException.new "ModelStack file not found" unless self.modelstack_filename
    end

    def read_file_content

      # TODO: check file exists
      self.generator.add_modelstack_file(self.modelstack_filename)

      ModelStack::DSLMethod::ModelStackFile.new(self.generator, self.modelstack_filename)
    end

    def generate
      self.generator.perform_generation
    end

  end

  class ModelStackFileException < Exception
  end
end