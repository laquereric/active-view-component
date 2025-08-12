# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      module Head
        # Component for rendering the head section of a page
        class Component < ActiveViewComponent::Core::Facet::Component
          attr_accessor :title
        end
      end
    end
  end
end
