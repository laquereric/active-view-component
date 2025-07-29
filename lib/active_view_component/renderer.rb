# frozen_string_literal: true

module ActiveViewComponent
  class Renderer
    attr_reader :view_context, :root_component
    
    def initialize(view_context, root_component = nil)
      @view_context = view_context
      @root_component = root_component
    end
    
    def render_tree(component_tree_id)
      root = ActiveViewComponent::Base.find(component_tree_id)
      render_component_tree(root)
    end
    
    def render_component_tree(component_record)
      # Render the current component
      output = component_record.render_component(view_context)
      
      # Recursively render children
      if component_record.children.any?
        children_output = component_record.children.map do |child|
          render_component_tree(child)
        end.join.html_safe
        
        # If the component supports slots or content, inject children
        if output.respond_to?(:gsub)
          # Simple placeholder replacement - can be enhanced
          output = output.gsub("{{children}}", children_output)
        else
          output = safe_join([output, children_output])
        end
      end
      
      output
    end
    
    private
    
    def safe_join(array)
      view_context.safe_join(array)
    end
  end
end
