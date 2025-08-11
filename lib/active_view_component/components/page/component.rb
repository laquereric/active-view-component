# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      class Component < ActiveViewComponent::Core::Facet::Component
        attr_accessor :title, :body_class, :lang, :dir, :meta_options, :html_attributes, :data_attributes, :show_header

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
