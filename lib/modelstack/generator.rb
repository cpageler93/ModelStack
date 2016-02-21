require 'json'

module ModelStack
  class Generator

    attr_accessor :modelstack_files

    ############################
    ##     DSL ATTRIBUTES     ##
    ############################

    attr_accessor :name
    attr_accessor :default_attributes
    attr_accessor :default_primary_key
    attr_accessor :models

    ############################

    def initialize
      self.modelstack_files = []
    end

    def add_modelstack_file(modelstack_filename)
      raise GeneratorException.new "ModelStack file #{File.basename(modelstack_filename)} added twice" if self.modelstack_files.include?(modelstack_filename)
      self.modelstack_files << modelstack_filename
    end

    def generate
      obj = {
        name: self.name,
        default_attributes: self.default_attributes.collect{|m|{
          identifier: m.identifier,
          type: m.type,
          nullable: m.nullable
        }},
        default_primary_key: self.default_primary_key,
        models: self.models.collect{|m|{
          identifier: m.get_identifier,
          name: m.get_name,
          description: m.get_description,
          attributes: m.attributes.collect{|a|{
            identifier: a.identifier,
            type: a.type,
            nullable: a.nullable
          }}
        }}
      }
      puts "generate #{JSON.pretty_generate(obj)}"
    end

  end

  class GeneratorException < Exception
  end
end