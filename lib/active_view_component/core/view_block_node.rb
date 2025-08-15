module ActiveViewComponent
  module Core
    # Represents a node in the component tree.
    class ViewBlockNode
      include ActiveViewComponent::Core::Concern::NodeHier

      attr_accessor :generator_klass, :file, :component, :props, :style
      attr_writer :label

      def self.create_root(generator_klass:, file:)
        new(generator_klass: generator_klass, file: file)
          .populate_peers
          .populate_children
      end

      def self.create_child(generator_klass:, file:, view_block_node:)
        new(generator_klass: generator_klass, view_block_node: view_block_node)
          .setup_as_child_of(view_block_node: view_block_node)
          .populate_peers
          .populate_children
      end

      def initialize(generator_klass:, file:)
        @generator_klass = generator_klass
        @file = file
      end

      def populate_peers
        @component = generator_klass.view_block_component_sibling_klass.new(view_block_node: self)
        @props = generator_klass.view_block_props_sibling_klass.new(view_block_node: self)
        @style = generator_klass.view_block_style_sibling_klass.new(view_block_node: self)
        self
      end

      def populate_children
        generator_klass.create_children_from(view_block_node: self)
        self
      end

      def label
        @label || @component.name
      end
    end
  end
end
