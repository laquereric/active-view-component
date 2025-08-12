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

## Real-World Example: Head Component

```ruby
class HeadComponent < ActiveViewComponent::Core::Facet::Component
  include ActiveViewComponent::Core::ErbParts

  # Page metadata attributes
  erb_attr :title, type: :string, default: "Default Page Title"
  erb_attr :charset, type: :string, default: "UTF-8"
  erb_attr :viewport, type: :string, default: "width=device-width, initial-scale=1"
end
```

### Usage in ERB Template:
```erb
<head>
  <title><%= title %></title>
  <meta charset="<%= charset %>">
  <meta name="viewport" content="<%= viewport %>">
</head>
```

### Component Instantiation:
```ruby
head = HeadComponent.new
head.title = "My Page Title"
head.charset = "UTF-8"
head.viewport = "width=device-width, initial-scale=1"
```

## Introspection

Access metadata about defined attributes:

```ruby
MyComponent.erb_attributes  # Returns hash of attribute configurations

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
