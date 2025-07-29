# frozen_string_literal: true

module ActiveViewComponent
  module ViewHelpers
    # Render a persisted component tree
    def render_active_view_component_tree(tree_id)
      renderer = ActiveViewComponent::Renderer.new(self)
      renderer.render_tree(tree_id)
    end
    
    # Render a component and capture it in the tree
    def render_with_capture(component, **options)
      if ActiveViewComponent.enabled
        # This will be captured by the TreeBuilder
        render(component, **options)
      else
        render(component, **options)
      end
    end
  end
end
