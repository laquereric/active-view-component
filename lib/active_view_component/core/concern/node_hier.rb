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

        # Prepare the node and its children for rendering
        # @param parent [Object] The parent object to set for this component
        def prepare(parent: nil)
          @parent = parent if parent
          prepare_children
        end

        # Prepare all children components
        def prepare_children
          @children ||= []

          # Prepare the children if they respond to prepare
          @children.each { |child| child.prepare(parent: self) }
        end

        # Find a child component by its name
        # @param sym [Symbol] The name of the child component to find
        # @return [Object, nil] The child component or nil if not found
        def child_named(sym)
          @children ||= []
          @children.find { |child| child.respond_to?(:name) && child.name == sym }
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

        # Get all descendants (children, grandchildren, etc.)
        # @return [Array] Array of all descendant components
        def descendants
          result = []
          @children ||= []
          @children.each do |child|
            result << child
            result.concat(child.descendants) if child.respond_to?(:descendants)
          end
          result
        end
      end
    end
  end
end
