# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      module Head
        # Component for rendering the head section of a page
        class Component < ActiveViewComponent::Core::Facet::Component
          include ActiveViewComponent::Core::ErbParts

          # Define ERB attributes for the head component
          erb_attr :title, type: :string, default: "Default Page Title"
          erb_attr :charset, type: :string, default: "UTF-8"
          erb_attr :viewport, type: :string, default: "width=device-width, initial-scale=1"

          # Define ERB nodes for head content
          # erb_node :meta, component_class: ActiveViewComponent::Components::Page::Head::Meta::Component
          # erb_node :stylesheets, multiple: true
          # erb_node :scripts, multiple: true
        end
      end
    end
  end
end
