module ActiveViewComponent
  module Core
    # Represents a node in the component tree.
    class ViewBlockNode
      include ActiveViewComponent::Core::Concern::NodeHier

      attr_accessor :generator, :component, :props, :style

      def self.create(generator:)
        new(generator: generator)
      end

      def initialize(generator:)
        @generator = generator
      end

      def label
        component.class.to_s.split('::')[-2].downcase
      end

    end
  end
end
