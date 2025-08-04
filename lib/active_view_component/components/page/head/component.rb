# frozen_string_literal: true
module ActiveViewComponent
  module Page
    module Head
  
      # Head Component for managing page head section
      class Component < Base::Component
        def self.props_class
          Props
        end
      end
    end
  end
end
