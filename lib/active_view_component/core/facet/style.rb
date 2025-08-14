# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Facet
      # Style facet for components
      class Style
        include ActiveViewComponent::Core::Concern::ViewBlock

        attr_accessor :html_attributes, :dir, :stylesheets, :scripts, :lang, :charset, :viewport, :inline_styles

        def initialize(view_block_node:)
          super()
          set_view_block_node(view_block_node: view_block_node)
        end
      end
    end
  end
end
