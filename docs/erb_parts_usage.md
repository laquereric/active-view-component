# ErbParts Concern Usage Examples

This document demonstrates how to use the `ActiveViewComponent::Core::ErbParts` concern in your components.

## Basic Usage

```ruby
class MyComponent < ActiveViewComponent::Core::Facet::Component
  include ActiveViewComponent::Core::ErbParts

  # Define ERB attributes with type coercion and defaults
  erb_attr :title, type: :string, default: "Default Title"
  erb_attr :count, type: :integer
  erb_attr :visible, type: :boolean, default: true
  erb_attr :description  # No type coercion, accepts any value

  # Define ERB nodes for child components or content
  erb_node :header, component_class: HeaderComponent
  erb_node :items, multiple: true  # Allow multiple items
  erb_node :footer, default_content: "<footer>Default Footer</footer>"
end
```

## ERB Attributes (`erb_attr`)

### Features:
- **Type Coercion**: Automatically converts values to specified types
- **Question Methods**: Provides `attribute?` methods to check if set
- **Metadata Storage**: Stores configuration for introspection

### Supported Types:
- `:string` - Converts to string using `to_s`
- `:integer` - Converts to integer using `to_i`
- `:boolean` - Converts to boolean (any truthy value becomes `true`)

### Example Usage:
```ruby
component = MyComponent.new
component.title = "My Title"
component.count = "123"  # Automatically converted to 123 (integer)
component.visible = "false"  # Converted to true (any non-nil value)

puts component.title    # "My Title"
puts component.count    # 123
puts component.visible  # true
puts component.title?   # true (attribute is set)
```

## ERB Nodes (`erb_node`)

### Features:
- **Single vs Multiple**: Support for single nodes or collections
- **Component Integration**: Can specify component classes for rendering
- **Default Content**: Provide fallback content when node is empty
- **Render Methods**: Automatic `render_*` methods for each node

### Single Node Example:
```ruby
erb_node :header, component_class: HeaderComponent

# Usage:
component.header = { title: "My Header", level: 2 }
rendered = component.render_header  # Renders HeaderComponent with the hash as attributes
```

### Multiple Nodes Example:
```ruby
erb_node :items, multiple: true

# Usage:
component.items = ["Item 1", "Item 2"]
component.add_item("Item 3")  # Automatically generated method
rendered = component.render_items  # Renders all items concatenated
```

### Default Content Example:
```ruby
erb_node :footer, default_content: "<footer>Default Footer</footer>"

# Usage:
rendered = component.render_footer  # Returns default content if no footer set
```

## Real-World Example: Head Component

```ruby
class HeadComponent < ActiveViewComponent::Core::Facet::Component
  include ActiveViewComponent::Core::ErbParts

  # Page metadata attributes
  erb_attr :title, type: :string, default: "Default Page Title"
  erb_attr :charset, type: :string, default: "UTF-8"
  erb_attr :viewport, type: :string, default: "width=device-width, initial-scale=1"

  # Child components and content
  erb_node :meta, component_class: MetaComponent
  erb_node :stylesheets, multiple: true
  erb_node :scripts, multiple: true
end
```

### Usage in ERB Template:
```erb
<head>
  <title><%= title %></title>
  <meta charset="<%= charset %>">
  <meta name="viewport" content="<%= viewport %>">
  
  <%= render_meta if meta? %>
  
  <% stylesheets.each do |stylesheet| %>
    <link rel="stylesheet" href="<%= stylesheet %>">
  <% end %>
  
  <% scripts.each do |script| %>
    <script src="<%= script %>"></script>
  <% end %>
</head>
```

### Component Instantiation:
```ruby
head = HeadComponent.new
head.title = "My Page Title"
head.charset = "UTF-8"
head.meta = { description: "Page description", keywords: "ruby, rails" }
head.add_stylesheet("styles.css")
head.add_stylesheet("theme.css")
head.add_script("app.js")
```

## Introspection

Access metadata about defined attributes and nodes:

```ruby
MyComponent.erb_attributes  # Returns hash of attribute configurations
MyComponent.erb_nodes      # Returns hash of node configurations

# Example output:
# { 
#   title: { type: :string, default: "Default Title" },
#   count: { type: :integer },
#   visible: { type: :boolean, default: true }
# }
```

## Benefits

1. **Declarative**: Clear, readable component definitions
2. **Type Safety**: Automatic type conversion and validation
3. **Flexible**: Support for various content types and structures
4. **Introspectable**: Access to metadata for debugging and tooling
5. **Consistent**: Standardized patterns across all components
