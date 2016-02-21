require 'modelstack/version.rb'
require 'modelstack/modelstack_file.rb'
require 'modelstack/modelstack_file_dsl.rb'
require 'modelstack/modelstack_file_dsl_methods/default_attributes.rb'
require 'modelstack/modelstack_file_dsl_methods/default_primary_key.rb'
require 'modelstack/modelstack_file_dsl_methods/attribute_reader.rb'
require 'modelstack/modelstack_file_dsl_methods/action_reader.rb'
require 'modelstack/modelstack_file_dsl_methods/model.rb'
require 'modelstack/modelstack_file_dsl_methods/controller.rb'
require 'modelstack/modelstack_file_dsl_methods/scope.rb'
require 'modelstack/generator.rb'
require 'modelstack/modelstack_attribute.rb'
require 'modelstack/modelstack_action.rb'

# third party code
require 'colored'
require 'commander'
require 'terminal-table'

module ModelStack
end