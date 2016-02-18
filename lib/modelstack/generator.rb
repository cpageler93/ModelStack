module ModelStack
  class Generator

    attr_accessor :modelstack_files

    def initialize
      self.modelstack_files = []
    end

    def add_modelstack_file(modelstack_filename)
      raise GeneratorException.new "ModelStack file #{File.basename(modelstack_filename)} added twice" if self.modelstack_files.include?(modelstack_filename)
      self.modelstack_files << modelstack_filename
    end

  end

  class GeneratorException < Exception
  end
end