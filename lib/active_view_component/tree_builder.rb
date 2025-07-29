# frozen_string_literal: true

module ActiveViewComponent
  class TreeBuilder
    attr_reader :root_component, :current_parent, :component_stack
    
    def initialize
      @root_component = nil
      @current_parent = nil
      @component_stack = []
    end
    
    def capture_render(&block)
      # Override ViewComponent rendering to capture the tree
      original_render = ViewComponent::Base.method(:render_in)
      
      ViewComponent::Base.define_singleton_method(:render_in) do |view_context, &render_block|
        # Create component record
        component_record = ActiveViewComponent::Base.create_from_component(
          self, 
          parent: TreeBuilder.current_parent
        )
        
        # Update tree state
        TreeBuilder.set_root(component_record) if TreeBuilder.root_component.nil?
        old_parent = TreeBuilder.current_parent
        TreeBuilder.set_current_parent(component_record)
        
        # Call original render
        result = original_render.call(view_context, &render_block)
        
        # Restore parent
        TreeBuilder.set_current_parent(old_parent)
        
        result
      end
      
      # Execute the block that will trigger rendering
      result = block.call
      
      # Restore original method
      ViewComponent::Base.define_singleton_method(:render_in, original_render)
      
      result
    end
    
    def self.current_instance
      @current_instance ||= new
    end
    
    def self.root_component
      current_instance.root_component
    end
    
    def self.current_parent
      current_instance.current_parent
    end
    
    def self.set_root(component)
      current_instance.instance_variable_set(:@root_component, component)
    end
    
    def self.set_current_parent(parent)
      current_instance.instance_variable_set(:@current_parent, parent)
    end
    
    def self.reset!
      @current_instance = new
    end
  end
end
