module ActiveViewComponent
  module Core
    # Represents a node in the component tree.
    class Node
      attr_accessor :component, :props, :style, :parent, :children

      def name
        self.class.to_s.split("::")[-2].underscore.to_sym
      end

      def child_named(sym)
        @children.find { |child| child.name == sym }
      end

      def prepare(parent: nil)
        @parent = parent if parent

        # Prepare the component if it responds to prepare
        @component.prepare(parent: self) if @component.respond_to?(:prepare)

        # Prepare the props if it responds to prepare
        @props.prepare(parent: self) if @props.respond_to?(:prepare)

        # Prepare the style if it responds to prepare
        @style.prepare(parent: self) if @style.respond_to?(:prepare)

        prepare_children(parent: self)
      end

      def prepare_children(parent: nil)
        @children ||= []
        @children.each { |child| child.prepare(parent: self) }
      end
    end
  end
end
