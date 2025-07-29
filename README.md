# ActiveViewComponent

ActiveViewComponent implements a new Rails rendering flow where every rendered page is persisted to the database as a tree of components using the ancestry gem. Each component inherits from ActiveRecord and has schema support for data persistence and retrieval.

## Features

- **Tree-based Component Storage**: Every rendered page is captured as a component tree
- **ActiveRecord Integration**: Components are stored in the database with full schema support
- **Ancestry Tree Structure**: Uses the ancestry gem for efficient tree operations
- **ViewComponent Compatibility**: Works with existing ViewComponent libraries
- **Automatic Persistence**: Optionally auto-captures component trees during rendering
- **Tree Re-rendering**: Stored component trees can be re-rendered from database data

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active-view-component'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active-view-component

## Setup

Run the generator to create the necessary migration and initializer:

```bash
rails generate active_view_component:install
rails db:migrate
```

## Usage

### Basic Component

```ruby
class HeaderComponent < ViewComponent::Base
  def initialize(title:, navigation_items: [])
    @title = title
    @navigation_items = navigation_items
  end
  
  private
  
  attr_reader :title, :navigation_items
end
```

### Controller Integration

The gem automatically captures component trees when rendering:

```ruby
class PagesController < ApplicationController
  def show
    # This will automatically capture the component tree
    render PageComponent.new(title: "Welcome")
  end
end
```

### Accessing Persisted Trees

```ruby
# Get the root component from the last render
root_component = controller.active_view_component_root

# Render a persisted tree by ID
render_active_view_component_tree(root_component.id)
```

### Configuration

```ruby
# config/initializers/active_view_component.rb
ActiveViewComponent.configure do |config|
  # Enable/disable the system
  config.enabled = true
  
  # Auto-persist component trees
  config.auto_persist = true
end
```

## How It Works

1. **Component Rendering**: When a ViewComponent is rendered, the system intercepts the render call
2. **Data Extraction**: Component instance variables are extracted and serialized
3. **Tree Building**: Components are stored in a tree structure using the ancestry gem
4. **Persistence**: Each component record contains the class name, data, and tree position
5. **Re-rendering**: Trees can be reconstructed by instantiating components from stored data

## Database Schema

The `active_view_components` table includes:

- `view_component_class_name`: The component class name
- `component_data`: Serialized component instance variables
- `render_options`: Options passed to the render method
- `ancestry`: Tree structure (from ancestry gem)
- `ancestry_depth`: Depth in the tree

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ericlaquer/active-view-component. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ericlaquer/active-view-component/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveViewComponent project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ericlaquer/active-view-component/blob/main/CODE_OF_CONDUCT.md).
