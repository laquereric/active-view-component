# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Concern
      # Concern that provides view block helpers for components
      # Allows components to access sibling classes for component, props, and style
      module ViewBlock
        extend ActiveSupport::Concern

        included do
          attr_accessor :view_block_parent
        end

        class_methods do
          # Returns the sibling Component class
          # Uses the same logic as ActiveViewComponent::Core::Facet::Component.name
          # to determine the component namespace and return the Component class
          def view_block_component_sibling_klass
            [name.split("::")[0..-2].join("::"), "Component"].join("::").constantize
          end

          # Returns the sibling Props class
          # Uses the same logic as ActiveViewComponent::Core::Facet::Component.name
          # to determine the component namespace and return the Props class
          def view_block_props_sibling_klass
            [name.split("::")[0..-2].join("::"), "Props"].join("::").constantize
          end

          # Returns the sibling Style class
          # Uses the same logic as ActiveViewComponent::Core::Facet::Component.name
          # to determine the component namespace and return the Style class
          def view_block_style_sibling_klass
            [name.split("::")[0..-2].join("::"), "Style"].join("::").constantize
          end
        end
      end
    end
  end
end
