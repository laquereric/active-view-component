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

        # Prepare the component if it responds to prepare
        @component.prepare(parent: self) if @component.respond_to?(:prepare)

        # Prepare the props if it responds to prepare
        @props.prepare(parent: self) if @props.respond_to?(:prepare)

        # Prepare the style if it responds to prepare
        @style.prepare(parent: self) if @style.respond_to?(:prepare)

        prepare_children
      end
    end
  end
end
