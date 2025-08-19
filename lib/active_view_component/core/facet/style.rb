# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Facet
      # Style facet for components
      class Style
        include ActiveViewComponent::Core::Concern::ViewBlock

        attr_accessor :html_attributes, :dir, :stylesheets, :scripts, :lang, :charset, :viewport, :inline_styles
      end
    end
  end
end
