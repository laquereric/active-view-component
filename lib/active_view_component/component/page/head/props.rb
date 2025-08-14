# frozen_string_literal: true

module ActiveViewComponent
  module Component
    module Page
      module Head
        # Props for the head component
        class Props < ActiveViewComponent::Core::Facet::Props
          attr_accessor :title
        end
      end
    end
  end
end
