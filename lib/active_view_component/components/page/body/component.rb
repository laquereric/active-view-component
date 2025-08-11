# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      module Body
        class Component < ActiveViewComponent::Core::Facet::Component
          attr_accessor :body_class, :data_attributes

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
