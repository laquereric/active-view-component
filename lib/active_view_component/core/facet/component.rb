# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Facet
      # Base class for all components in the ActiveViewComponent framework.
      class Component < ViewComponent::Base
        include ActiveViewComponent::Core::Concern::ViewBlock
        include ActiveViewComponent::Core::Concern::ErbParts

        def name
          self.class.to_s.split("::")[-2].underscore.to_sym
        end

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
