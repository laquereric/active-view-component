module ActiveViewComponent
  module Core
    # Represents a node in the component tree.
    class ViewBlockNode
      include ActiveViewComponent::Core::Concern::NodeHier

      attr_accessor :component, :props, :style
      attr_writer :label

      def initialize(
        generator_klass:,
        view_block_node: nil
      )
        setup_view_block_node_hier(view_block_node: view_block_node) if view_block_node

        @component = generator_klass.view_block_component_sibling_klass.new(view_block_node: self)
        @props = generator_klass.view_block_props_sibling_klass.new(view_block_node: self)
        @style = generator_klass.view_block_style_sibling_klass.new(view_block_node: self)
      end

      def label
        @label || @component.name
      end
    end
  end
end
