module ActiveViewComponent
  module Core
    # Represents a node in the component tree.
    class ViewBlockNode
      include ActiveViewComponent::Core::Concern::NodeHier

      attr_accessor :component, :props, :style

      def child_named(sym)
        @children.find { |child| child.component.name == sym }
      end

      def prepare(parent: nil)
        @parent = parent if parent
        begin
          # Prepare the component if it responds to prepare
          @component.prepare_view_block_facet(view_block_parent: self)

          # Prepare the props if it responds to prepare
          @props.prepare_view_block_facet(view_block_parent: self)

          # Prepare the style if it responds to prepare
          @style.prepare_view_block_facet(view_block_parent: self)
        rescue StandardError => e
          # Handle any errors that occur during preparation
          puts "Error preparing view block: #{e.message}"
        end
        prepare_children
      end
    end
  end
end
