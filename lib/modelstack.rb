require 'modelstack/version.rb'
require 'modelstack/modelstack_file.rb'

require 'modelstack/dsl_method/modelstack_file.rb'
require 'modelstack/dsl_method/action.rb'
require 'modelstack/dsl_method/controller.rb'
require 'modelstack/dsl_method/default_attributes.rb'
require 'modelstack/dsl_method/default_primary_key.rb'
require 'modelstack/dsl_method/resources.rb'
require 'modelstack/dsl_method/scope.rb'
require 'modelstack/dsl_method/model.rb'

require 'modelstack/dsl_class/action.rb'
require 'modelstack/dsl_class/attribute.rb'
require 'modelstack/dsl_class/scope.rb'
require 'modelstack/dsl_class/model.rb'
require 'modelstack/dsl_class/controller.rb'
require 'modelstack/dsl_class/generator.rb'

require 'modelstack/dsl_reader/action.rb'
require 'modelstack/dsl_reader/attribute.rb'

require 'modelstack/generator/collector.rb'
require 'modelstack/generator/base.rb'


# third party code
require 'colored'
require 'commander'
require 'terminal-table'
require 'active_support/inflector'

module ModelStack
end