# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      module Head
        class Component < ActiveViewComponent::Core::Facet::Component
          attr_accessor :title, :stylesheets, :scripts, :inline_styles, :inline_scripts, :meta_options

          def initialize(**options)
            super()
            # Initialize from options passed by the generator
            options.each do |key, value|
              instance_variable_set("@#{key}", value) if respond_to?("#{key}=")
            end
          end
        end
      end
    end
  end
end
