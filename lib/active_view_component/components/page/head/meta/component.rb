# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      module Head
        module Meta
          class Component < ActiveViewComponent::Core::Facet::Component
            attr_accessor :robots, :keywords, :description, :author, :charset, :viewport, :twitter_card, :custom_meta,
                          :og_title, :og_description

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
end
