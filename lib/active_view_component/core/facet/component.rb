# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Facet
      # Base class for all components in the ActiveViewComponent framework.
      class Component < ViewComponent::Base
        include ActiveViewComponent::Core::ErbParts
        attr_accessor :parent, :children

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

        def prepare(parent: nil)
          @parent = parent if parent
          prepare_children(parent: self)
        end

        def prepare_children(parent: nil)
          @children ||= []

          # Prepare the children if they respond to prepare
          @children.each { |child| child.prepare(parent: self) }
        end
      end
    end
  end
end
