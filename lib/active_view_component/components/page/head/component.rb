# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      module Head
        # Component for rendering the head section of a page
        class Component < ActiveViewComponent::Core::Facet::Component
          include ActiveViewComponent::Core::Concern::ErbParts

          # Define ERB attributes for the head component
          erb_attr :title, type: :string, default: "Default Page Title"
          erb_attr :charset, type: :string, default: "UTF-8"
          erb_attr :viewport, type: :string, default: "width=device-width, initial-scale=1"
          erb_attr :meta, type: :view_block_child
          erb_attr :link, type: :view_block_child
        end
      end
    end
  end
end
