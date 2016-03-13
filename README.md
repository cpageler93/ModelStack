# ModelStack
Generates code for server and client applications

🚸 **This gem is still under heavy development!** ☝😳

# Installation

  sudo gem install modelstack

# Example

You can define your models, interfaces, ... like this:
```ruby
name 'ModelStack Example API'

default_attributes do
  attribute :id,          type: :integer,   nullable: false
  attribute :created_at,  type: :datetime,  nullable: false
  attribute :updated_at,  type: :datetime,  nullable: true
end

default_primary_key :id

model :user do
  name 'User'
  description 'User Model'

  default_attributes
  default_primary_key

  attribute :name,  type: :string,  nullable: false
  attribute :age,   type: :integer, nullable: true
end

scope path: 'api' do

  resources :users do
    action :search, http_method: :get, on: :collection
  end
  
end

generate 'Rails' do
  output_to 'generated/rails'
end
```
More examples can be found at [modelstack-examples](https://github.com/cpageler93/ModelStack/tree/master/example)


# Generators
Name            | Server/Client     | Description                            | GitHub
----------------|-------------------|----------------------------------------|-----
Rails           | Server            | Generates Code for Ruby on Rails Applications |  [cpageler93/ModelStack-Generator-Rails](https://github.com/cpageler93/ModelStack-Generator-Rails)
