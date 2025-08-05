# frozen_string_literal: true
module ActiveViewComponent
  module Components
    module Page
      module Head 
        class Props < ActiveViewComponent::Core::Facet::Props
          attr_accessor :title
        end
      end
    end
  end
end