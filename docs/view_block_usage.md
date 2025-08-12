# ViewBlock Concern Usage Examples

This document demonstrates how to use the `ActiveViewComponent::Core::Concern::ViewBlock` concern in your components.

## Overview

The ViewBlock concern provides class methods to access sibling classes within the same component namespace. This is useful for components that need to reference their associated Props, Style, or Component classes programmatically.

## Basic Usage

Include the concern in your component class:

```ruby
module MyApp
  module Components
    module UserProfile
      class Component < ActiveViewComponent::Core::Facet::Component
        include ActiveViewComponent::Core::Concern::ViewBlock
        
        # Now you can use the view_block methods
      end
      
      class Props < ActiveViewComponent::Core::Facet::Props
        # Props implementation
      end
      
      class Style
        # Style implementation
      end
    end
  end
end
```

## Available Methods

### `view_block_component_sibling_klass`

Returns the Component class from the same namespace:

```ruby
MyApp::Components::UserProfile::Component.view_block_component_sibling_klass
# => MyApp::Components::UserProfile::Component
```

### `view_block_props_sibling_klass`

Returns the Props class from the same namespace:

```ruby
MyApp::Components::UserProfile::Component.view_block_props_sibling_klass
# => MyApp::Components::UserProfile::Props
```

### `view_block_style_sibling_klass`

Returns the Style class from the same namespace:

```ruby
MyApp::Components::UserProfile::Component.view_block_style_sibling_klass
# => MyApp::Components::UserProfile::Style
```

## How It Works

The ViewBlock concern uses the same logic as `ActiveViewComponent::Core::Facet::Component.name` to determine the component namespace. It splits the current class name and constructs the sibling class names by replacing the last part with "Component", "Props", or "Style".

For example, if your component is:
- `MyApp::Components::UserProfile::Component`

The sibling classes are found at:
- `MyApp::Components::UserProfile::Component`
- `MyApp::Components::UserProfile::Props`
- `MyApp::Components::UserProfile::Style`

## Error Handling

If a sibling class doesn't exist, the methods will raise a `NameError`:

```ruby
# If MyApp::Components::UserProfile::Style doesn't exist:
MyApp::Components::UserProfile::Component.view_block_style_sibling_klass
# => NameError: uninitialized constant MyApp::Components::UserProfile::Style
```

## Integration with Existing Components

The ViewBlock concern works seamlessly with existing ActiveViewComponent components and can be included alongside other concerns like ErbParts:

```ruby
class Component < ActiveViewComponent::Core::Facet::Component
  include ActiveViewComponent::Core::Concern::ErbParts
  include ActiveViewComponent::Core::Concern::ViewBlock
  
  erb_attr :title, type: :string
  
  def component_class
    self.class.view_block_component_sibling_klass
  end
  
  def props_class
    self.class.view_block_props_sibling_klass
  end
end
```
