# NodeHier Concern Usage Examples

This document demonstrates how to use the `ActiveViewComponent::Core::NodeHier` concern in your components.

## Overview

The NodeHier concern provides functionality for creating hierarchical relationships between components. It adds `:parent` and `:children` instance attributes along with methods to manage parent-child relationships and navigate the component tree.

## Basic Usage

Include the concern in your component class:

```ruby
class MyComponent
  include ActiveViewComponent::Core::NodeHier
  
  def initialize(name)
    @name = name
  end
  
  def name
    @name
  end
end
```

## Available Attributes

### `:parent`
- Stores a reference to the parent component
- Can be set and retrieved using `parent` and `parent=`

### `:children`
- Stores an array of child components
- Automatically initialized as an empty array when needed

## Available Methods

### `prepare(parent: nil)`
Sets the parent component and prepares all children:

```ruby
component = MyComponent.new(:main)
parent_component = MyComponent.new(:container)

component.prepare(parent: parent_component)
# Sets component.parent = parent_component and calls prepare_children
```

### `prepare_children`
Calls `prepare(parent: self)` on all children that respond to the method:

```ruby
component.prepare_children
# Calls prepare(parent: component) on each child
```

### `add_child(child)`
Adds a child component and sets its parent:

```ruby
parent = MyComponent.new(:parent)
child = MyComponent.new(:child)

parent.add_child(child)
# child is added to parent.children array
# child.parent is set to parent
```

### `remove_child(child)`
Removes a child component and clears its parent:

```ruby
parent.remove_child(child)
# child is removed from parent.children array
# child.parent is set to nil
```

### `child_named(sym)`
Finds a child component by its name:

```ruby
child1 = MyComponent.new(:first_child)
child2 = MyComponent.new(:second_child)
parent.add_child(child1)
parent.add_child(child2)

found_child = parent.child_named(:first_child)
# Returns child1
```

### `has_children?`
Checks if the component has any children:

```ruby
parent.has_children?
# Returns true if children array is not empty, false otherwise
```

### `descendants`
Returns all descendants (children, grandchildren, etc.):

```ruby
grandchild = MyComponent.new(:grandchild)
child.add_child(grandchild)
parent.add_child(child)

all_descendants = parent.descendants
# Returns [child, grandchild]
```

## Integration with Existing Classes

The NodeHier concern is automatically included in the following ActiveViewComponent classes:

- `ActiveViewComponent::Core::Facet::Component`
- `ActiveViewComponent::Core::Facet::Props`
- `ActiveViewComponent::Core::Facet::Style`
- `ActiveViewComponent::Core::Node`

## Complete Example

```ruby
# Create a component hierarchy
page = MyComponent.new(:page)
header = MyComponent.new(:header)
nav = MyComponent.new(:nav)
content = MyComponent.new(:content)

# Build the hierarchy
page.add_child(header)
page.add_child(content)
header.add_child(nav)

# Navigate the hierarchy
page.has_children?                    # => true
page.children.size                    # => 2
page.child_named(:header)             # => header component
header.parent                         # => page component
page.descendants                      # => [header, content, nav]

# Prepare the entire tree
page.prepare
# This calls prepare on all components in the hierarchy
```

## Advanced Usage with Custom Components

```ruby
class CustomComponent
  include ActiveViewComponent::Core::NodeHier
  
  attr_reader :name, :data
  
  def initialize(name, data: {})
    @name = name
    @data = data
  end
  
  def find_descendant_by_data(key, value)
    descendants.find { |desc| desc.data[key] == value }
  end
  
  def depth
    return 0 unless parent
    parent.depth + 1
  end
end

# Usage
root = CustomComponent.new(:root, data: { type: 'container' })
child = CustomComponent.new(:child, data: { type: 'content', id: 123 })
root.add_child(child)

found = root.find_descendant_by_data(:id, 123)  # => child component
child.depth                                     # => 1
```
