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

        def prepare_view_block_facet(view_block_parent:)
          @view_block_parent = view_block_parent
        end

        def view_block_children
          view_block_parent.children
        end

        def view_block_children_labeled(label:)
          view_block_children.select { |child| child.label == label }
        end

        class_methods do
          def view_block_namespace
            name.split("::")[0..-2].join("::")
          end

          def view_block_klass(klassname:)
            [view_block_namespace, klassname].join("::").constantize
          end

          # Returns the sibling Component class
          # Uses the same logic as ActiveViewComponent::Core::Facet::Component.name
          # to determine the component namespace and return the Component class
          def view_block_component_sibling_klass
            view_block_klass(klassname: "Component")
          end

          # Returns the sibling Props class
          # Uses the same logic as ActiveViewComponent::Core::Facet::Component.name
          # to determine the component namespace and return the Props class
          def view_block_props_sibling_klass
            view_block_klass(klassname: "Props")
          end

          # Returns the sibling Style class
          # Uses the same logic as ActiveViewComponent::Core::Facet::Component.name
          # to determine the component namespace and return the Style class
          def view_block_style_sibling_klass
            view_block_klass(klassname: "Style")
          end
        end
      end
    end
  end
end
