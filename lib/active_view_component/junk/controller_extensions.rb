# frozen_string_literal: true

module ActiveViewComponent
  module ControllerExtensions
    extend ActiveSupport::Concern
    
    included do
      around_action :capture_component_tree, if: -> { ActiveViewComponent.enabled }
    end
    
    private
    
    def capture_component_tree
      if ActiveViewComponent.auto_persist
        tree_builder = ActiveViewComponent::TreeBuilder.new
        tree_builder.capture_render do
          yield
        end
        
        # Store the root component ID for later retrieval
        @active_view_component_root = tree_builder.root_component
      else
        yield
      end
    end
    
    def active_view_component_root
      @active_view_component_root
    end
  end
end
