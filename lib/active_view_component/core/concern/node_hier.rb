# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Concern
      # Concern that provides node hierarchy functionality for components
      # Allows components to form parent-child relationships in a tree structure
      module NodeHier
        extend ActiveSupport::Concern

        included do
          attr_accessor :parent, :children
        end

        def setup_as_child_of(view_block:)
          @parent = view_block
          @parent.add_child(self)
          binding.pry
          self
        end

        # Add a child to this component
        # @param child [Object] The child component to add
        def add_child(child)
          @children ||= []
          @children << child
          child.parent = self if child.respond_to?(:parent=)
        end

        # Remove a child from this component
        # @param child [Object] The child component to remove
        def remove_child(child)
          @children ||= []
          @children.delete(child)
          child.parent = nil if child.respond_to?(:parent=)
        end

        # Check if this component has any children
        # @return [Boolean] true if the component has children, false otherwise
        def has_children?
          !!(@children && !@children.empty?)
        end

        def children_labeled(label:)
          @view_block_children.filter { |child| child.label == label }
        end
      end
    end
  end
end
