# Usage Examples

## Setting up ActiveViewComponent in a Rails App

### 1. Installation

Add to your Gemfile:
```ruby
gem 'active-view-component'
```

Run bundle install and generate the required files:
```bash
bundle install
rails generate active_view_component:install
rails db:migrate
```

### 2. Create Components

```ruby
# app/components/page_component.rb
class PageComponent < ViewComponent::Base
  def initialize(title:, body_class: nil)
    @title = title
    @body_class = body_class
  end
  
  private
  
  attr_reader :title, :body_class
end
```

```erb
<!-- app/components/page_component.html.erb -->
<html>
  <head>
    <title><%= title %></title>
  </head>
  <body class="<%= body_class %>">
    {{children}}
  </body>
</html>
```

```ruby
# app/components/header_component.rb
class HeaderComponent < ViewComponent::Base
  def initialize(title:, navigation_items: [])
    @title = title
    @navigation_items = navigation_items
  end
  
  private
  
  attr_reader :title, :navigation_items
end
```

### 3. Controller Usage

```ruby
# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def show
    # This automatically captures the component tree
    @page = PageComponent.new(
      title: "Welcome to My Site",
      body_class: "home-page"
    )
    
    @header = HeaderComponent.new(
      title: "My Site",
      navigation_items: [
        { text: "Home", url: "/" },
        { text: "About", url: "/about" }
      ]
    )
    
    render @page
  end
  
  def replay
    # Render a previously captured tree
    tree_id = params[:tree_id]
    render html: render_active_view_component_tree(tree_id)
  end
end
```

### 4. View Template

```erb
<!-- app/views/pages/show.html.erb -->
<%= render @page do %>
  <%= render @header %>
  <main>
    <h1>Welcome!</h1>
    <p>This page structure is automatically persisted.</p>
  </main>
<% end %>
```

### 5. Accessing Persisted Trees

```ruby
# In a controller or service
class ComponentTreeService
  def self.latest_page_tree
    ActiveViewComponent::Base.roots.order(created_at: :desc).first
  end
  
  def self.trees_for_component(component_class_name)
    ActiveViewComponent::Base.by_component_class(component_class_name)
  end
  
  def self.render_tree(tree_id, view_context)
    renderer = ActiveViewComponent::Renderer.new(view_context)
    renderer.render_tree(tree_id)
  end
end
```

### 6. Configuration

```ruby
# config/initializers/active_view_component.rb
ActiveViewComponent.configure do |config|
  # Enable/disable the system
  config.enabled = Rails.env.production? ? false : true
  
  # Auto-persist component trees (can be disabled for performance)
  config.auto_persist = true
end
```

## Advanced Usage

### Custom Component Data Extraction

By default, ActiveViewComponent extracts all instance variables. You can customize this:

```ruby
class CustomComponent < ViewComponent::Base
  def initialize(data:, secret_data:)
    @data = data
    @secret_data = secret_data # This won't be persisted
  end
  
  # Override to control what gets persisted
  def self.extract_component_data(component)
    {
      data: component.instance_variable_get(:@data)
      # secret_data is intentionally excluded
    }
  end
end
```

### Manual Tree Building

```ruby
# Disable auto-persistence for fine control
ActiveViewComponent.configure do |config|
  config.auto_persist = false
end

# Manually build trees
tree_builder = ActiveViewComponent::TreeBuilder.new
root_component = tree_builder.capture_render do
  render MyPageComponent.new(title: "Manual Tree")
end

# Later, render the tree
renderer = ActiveViewComponent::Renderer.new(view_context)
output = renderer.render_component_tree(root_component)
```

## Database Queries

### Finding Trees

```ruby
# All root components (top-level pages)
ActiveViewComponent::Base.roots

# Find by component type
ActiveViewComponent::Base.by_component_class("PageComponent")

# Tree traversal
root = ActiveViewComponent::Base.find(tree_id)
root.descendants  # All components in the tree
root.children     # Direct children
root.path         # Path from root to this component

# Recent trees
ActiveViewComponent::Base.order(created_at: :desc).limit(10)
```

This system enables powerful features like:
- Page replay/debugging
- A/B testing with component variations  
- Analytics on component usage
- Undo/redo functionality
- Template evolution tracking
