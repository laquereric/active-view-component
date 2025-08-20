# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Facet
      # Base class for all components in the ActiveViewComponent framework.
      class Component < ViewComponent::Base
        include ActiveViewComponent::Core::Concern::ViewBlock
        include ActiveViewComponent::Core::Concern::ErbParts

        def initialize
          p "#{self} initialize"
          super
        end

      end
    end
  end
end
