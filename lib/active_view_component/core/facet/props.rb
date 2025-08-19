# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Facet
      # Props for the component
      class Props
        include ActiveViewComponent::Core::Concern::ViewBlock

        def initialize
          p "#{self} initialize"
          super
        end
      end
    end
  end
end
