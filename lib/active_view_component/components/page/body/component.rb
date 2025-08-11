# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      module Body
        class Component < ActiveViewComponent::Core::Facet::Component
          attr_accessor :body_class, :data_attributes

          def initialize(body_class: nil, data_attributes: {}, **_options)
            super()
            @body_class = body_class
            @data_attributes = data_attributes || {}
          end
        end
      end
    end
  end
end
