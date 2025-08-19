module ActiveViewComponent
  module Core
    # Represents a node in the component tree.
    class ViewBlockNode
      include ActiveViewComponent::Core::Concern::NodeHier

      attr_accessor :generator, :component, :props, :style
      attr_writer :label

      def self.create(generator:)
        new(generator: generator)
      end

      def initialize(generator:)
        @generator = generator
      end

      def label
        @label || @component.name
      end

    end
  end
end
