# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Facet
      # Props for the component
      class Props < Hash
        include ActiveViewComponent::Core::Concern::ViewBlock
        def initialize(view_block_parent:)
          super()
          set_view_block_parent(view_block_parent: view_block_parent)
        end
      end
    end
  end
end
