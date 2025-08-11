# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      module Head
        class Component < ActiveViewComponent::Core::Facet::Component
          attr_accessor :title, :stylesheets, :scripts, :inline_styles, :inline_scripts, :meta_options

          def initialize(
            title: nil,
            stylesheets: [],
            scripts: [],
            inline_styles: nil,
            inline_scripts: nil,
            meta_options: {},
            **_options
          )
            super()
            @title = title
            @stylesheets = stylesheets || []
            @scripts = scripts || []
            @inline_styles = inline_styles
            @inline_scripts = inline_scripts
            @meta_options = meta_options || {}
          end
        end
      end
    end
  end
end
