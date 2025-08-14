# frozen_string_literal: true

module ActiveViewComponent
  module Component
    module Page
      module Head
        module Meta
          # Component for rendering meta tags in the head section
          class Component < ActiveViewComponent::Core::Facet::Component
            erb_attr :viewport
            erb_attr :apple_mobile_web_app_capable
            erb_attr :mobile_web_app_capable
          end
        end
      end
    end
  end
end
